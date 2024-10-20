//
//  NotificationsViewModel.swift
//  InstagramSwiftUI
//
//  Created by serhat on 20.10.2024.
//

import Foundation
import Firebase

final class NotificationsViewModel: ObservableObject {
    @Published var notifications: [Notification] = []
    
    /// Initializes the ViewModel and automatically fetches notifications for the current user
    init() {
        fetchNotifications()
    }
    
    
    /// Function to fetch notifications for the current authenticated user.
    /// This function is responsible for querying Firestore to retrieve notifications associated with the user.
    func fetchNotifications() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        
        let query = COLLECTION_NOTIFICATIONS.document(uid).collection("user-notifications")
            .order(by: "timestamp", descending: true)
        
        query.getDocuments { snapshot, error in
            if let _ = error { return }
            guard let documents = snapshot?.documents else { return }
            
            self.notifications = documents.compactMap({ try? $0.data(as: Notification.self)})
            print(self.notifications)
        }
        
    }
    
    
    /// Static function to upload a new notification for a specific user.
    /// This function allows the app to send notifications when events such as likes, comments, or follows occur.
    /// The notification is uploaded to Firestore under the recipient’s "user-notifications" collection.
    static func uploadNotifications(toUid uid: String, type: NotificationType, post: Post? = nil) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        
        
        var data: [String: Any] = ["timestamp": Timestamp(date: Date()),
                                   "username": user.username,
                                   "uid": user.id ?? "",
                                   "profileImageUrl": user.profileImageUrl,
                                   "type": type.rawValue
        ]
        
        if let post = post, let postId = post.id {
            data["postId"] = postId
        }
        
        COLLECTION_NOTIFICATIONS.document(uid).collection("user-notifications").addDocument(data: data) { error in
            if let _ = error { return }
            
            print("Succesfully saved notification.")
        }
        
        
    }
}
