//
//  FeedCellViewModel.swift
//  InstagramSwiftUI
//
//  Created by serhat on 18.10.2024.
//

import Foundation

final class FeedCellViewModel: ObservableObject {
    @Published var post: Post
    
    var timestampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: post.timestamp.dateValue(), to: Date()) ?? ""
    }
    
    
    /// Initializes the view model with a post and checks if the user has liked the post.
    /// - Parameter post: The `Post` object that this view model will manage.
    init(post: Post) {
        self.post = post
        checkIfUserLikedPost()
    }
    
    
    /// Likes the post by adding an entry to both the "post-likes" collection of the post and
    /// the "user-likes" collection of the current user in Firestore.
    /// - This method increments the `likes` count on the post and sets `didLike` to `true`.
    func like() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        guard let postId = post.id else { return }
        
        COLLECTION_POSTS.document(postId).collection("post-likes")
            .document(uid).setData([:]) { e in
                if let _ = e { return }
                COLLECTION_USERS.document(uid).collection("user-likes")
                    .document(postId).setData([:]) { error in
                        if let _ = error { return }
                        COLLECTION_POSTS.document(postId).updateData(["likes" : self.post.likes + 1]) { error in
                            if let _ = error { return }
                            NotificationsViewModel.uploadNotifications(toUid: self.post.ownerUid, type: .like, post: self.post)
                            
                            self.post.didLike = true
                            self.post.likes += 1
                        }
                        
                    }
                
            }
    }
    

    /// Unlikes the post by removing entries from both "post-likes" and "user-likes" collections in Firestore.
    /// - This method decrements the `likes` count on the post and sets `didLike` to `false`.
    func unlike() {
        guard post.likes > 0 else { return }
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        guard let postId = post.id else { return }
        
        COLLECTION_POSTS.document(postId).collection("post-likes").document(uid).delete { error in
            if let _ = error { return }
            COLLECTION_USERS.document(uid).collection("user-likes").document(postId).delete { er in
                if let _ = er { return }
                COLLECTION_POSTS.document(postId).updateData(["likes" : self.post.likes - 1]) { e in
                    if let _ = e { return }
                    self.post.didLike = false
                    self.post.likes -= 1
                }
            }
        }
    }
    
    
    /// Checks if the user has liked the post by querying the "user-likes" collection in Firestore.
    /// - If the user has liked the post, sets `didLike` to `true`, otherwise `false`.
    func checkIfUserLikedPost() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        guard let postId = post.id else { return }
        
        COLLECTION_USERS.document(uid).collection("user-likes").document(postId).getDocument { snapshot, error in
            if let _ = error { return }
            guard let didLike = snapshot?.exists else { return }
            self.post.didLike = didLike
        }
    }
}
