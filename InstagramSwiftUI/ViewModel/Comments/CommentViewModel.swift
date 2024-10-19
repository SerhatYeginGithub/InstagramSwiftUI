//
//  CommentViewModel.swift
//  InstagramSwiftUI
//
//  Created by serhat on 19.10.2024.
//

import Foundation
import Firebase

final class CommentViewModel: ObservableObject {
    
    private let post: Post
    @Published var comments: [Comment] = []
    @Published var commentText: String = ""
    
    
    /// Initializes the view model with the provided post and fetches its comments.
    /// - Parameter post: The post for which to manage and display comments.
    init(post: Post) {
        self.post = post
        fetchComments()
    }
    
    
    /// Uploads a new comment to the Firestore for the current post.
    /// - Parameter commentText: The text of the comment to be uploaded.
    func uploadComment(commentText: String) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        guard let postId = post.id else { return }
        
        let data: [String: Any] = [ "username": user.username,
                                    "profileImageUrl": user.profileImageUrl,
                                    "uid": user.id ?? "",
                                    "timestamp": Timestamp(date: Date()),
                                    "postOwnerUid": post.ownerUid,
                                    "commentText": commentText ]
        
        COLLECTION_POSTS.document(postId).collection("post-comments").addDocument(data: data) { error in
            if let _ = error { return }
            self.commentText = ""
            
        }
    }
    
    
    /// Fetches comments for the current post from Firestore and updates the `comments` array.
    func fetchComments() {
        guard let postId = post.id else { return }
        
        let query = COLLECTION_POSTS.document(postId).collection("post-comments")
            .order(by: "timestamp", descending: true)
            .limit(to: 30)
        
        query.addSnapshotListener { snapshot, error in
            if let _ = error { return }
            
            guard let addedDocs = snapshot?.documentChanges.filter({$0.type == .added}) else { return }
            self.comments = addedDocs.compactMap({ try? $0.document.data(as: Comment.self)})
            
        }
    }
}
