//
//  ProfileViewModel.swift
//  InstagramSwiftUI
//
//  Created by serhat on 17.10.2024.
//

import Foundation

@MainActor
final class ProfileViewModel: ObservableObject {
    @Published var user: User
    
    /// Initializes the view model with the provided user and automatically checks if the user is followed.
    /// - Parameter user: The user whose profile is being viewed or managed.
    init(user: User) {
        self.user = user
        Task {
            await checkIfUserisFollowed()
            fetchUserStatus()
        }
    }
    
    
    /// Follows the user asynchronously by sending a follow request to the backend.
    /// Upon success, the user's `isFollowed` property is set to `true`, and a follow notification is uploaded.
    func follow() async {
        guard let uid = user.id else { return }
        
        do {
            try await UserService.shared.follow(uid: uid)
            NotificationsViewModel.uploadNotifications(toUid: uid, type: .follow)
            user.isFollowed = true
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    /// Unfollows the user asynchronously by sending an unfollow request to the backend.
    /// Upon success, the user's `isFollowed` property is set to `false`.
    func unfollow() async {
        guard let uid = user.id else { return }
        
        do {
            try await UserService.shared.unfollow(uid: uid)
            user.isFollowed = false
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    /// Checks asynchronously if the user is currently followed by the logged-in user.
    /// Updates the `isFollowed` property of the user based on the result.
    func checkIfUserisFollowed() async {
        guard !user.isCurrentUser else { return }
        guard let uid = user.id else { return }
        
        do {
            let isFollowed = try await UserService.shared.checkIfUserIsFollowed(uid: uid)
            user.isFollowed = isFollowed
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchUserStatus() {
        guard let uid = user.id else { return }
        
        COLLECTION_FOLLOWING.document(uid).collection(COLLECTION_USER_FOLLOWING).getDocuments { snapshot, error in
            if let _ = error { return }
            guard let following = snapshot?.documents.count else { return }
            
            COLLECTION_FOLLOWERS.document(uid).collection(COLLECTION_USER_FOLLOWERS).getDocuments { snapshot, error in
                if let _ = error { return }
                guard let followers = snapshot?.documents.count else { return }
                
                COLLECTION_POSTS.whereField("ownerUid", isEqualTo: uid).getDocuments { snapshot, error in
                    if let _ = error { return }
                    guard let post = snapshot?.documents.count else { return }
                    self.user.userStatus = UserStatus(following: following, posts: post, followers: followers)
                }
            }
        }
    }
}
