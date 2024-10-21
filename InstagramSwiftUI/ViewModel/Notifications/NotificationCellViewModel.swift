//
//  NotificationCellViewModel.swift
//  InstagramSwiftUI
//
//  Created by serhat on 20.10.2024.
//

import Foundation

@MainActor
final class NotificationCellViewModel: ObservableObject {
    @Published var notification: Notification
    
    var timestampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: notification.timestamp.dateValue(), to: Date()) ?? ""
    }
    
    /// Initializes the view model with a notification and triggers tasks to check user follow status,
    /// fetch post details related to the notification, and fetch the user details related to the notification.
    init(notification: Notification)  {
        self.notification = notification
        Task {
            await checkIfUserisFollowed()
            fetchNotificationPost()
            fetchNotificationUser()
        }
    }
    
    
    
    /// Follows the user who triggered the notification. Updates the follow status
    /// and uploads a "follow" notification to the backend.
    func follow() async {
        
        
        do {
            try await UserService.shared.follow(uid: notification.uid)
            NotificationsViewModel.uploadNotifications(toUid: notification.uid, type: .follow)
            notification.isFollowed = true
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /// Unfollows the user who triggered the notification. Updates the follow status.
    func unfollow() async {
        
        
        do {
            try await UserService.shared.unfollow(uid: notification.uid)
            notification.isFollowed = false
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    /// Checks if the user who triggered the notification is currently followed by the logged-in user.
    /// This is only applicable if the notification is of type "follow".
    func checkIfUserisFollowed() async {
        guard notification.type == .follow else { return }
        
        do {
            let isFollowed = try await UserService.shared.checkIfUserIsFollowed(uid: notification.uid)
            notification.isFollowed = isFollowed
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    /// Fetches the post data associated with the notification if there is a postId.
    /// Retrieves the post document from the COLLECTION_POSTS and attempts to decode it into a Post model.
    func fetchNotificationPost() {
        guard let postId = notification.postId else { return }
        
        COLLECTION_POSTS.document(postId).getDocument { snapshot, error in
            if let _ = error  { return }
            self.notification.post = try? snapshot?.data(as: Post.self)
        }
    }
    
    /// Fetches the user data associated with the notification.
    /// Retrieves the user document from the COLLECTION_USERS and attempts to decode it into a User model.
    func fetchNotificationUser() {
        COLLECTION_USERS.document(notification.uid).getDocument { snapshot, error in
            if let _ = error { return }
            self.notification.user = try? snapshot?.data(as: User.self)
        }
    }
    
}
