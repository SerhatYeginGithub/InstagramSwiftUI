//
//  FeedViewModel.swift
//  InstagramSwiftUI
//
//  Created by serhat on 17.10.2024.
//

import Foundation


final class FeedViewModel: ObservableObject {
    @Published var posts: [Post] = []
    
    /// Initializes the `FeedViewModel` by fetching the posts when the view model is created.
    init() {
        fetchPosts()
    }
    
    /// Fetches posts from the Firestore database, ordered by their timestamp in descending order (newest first).
    /// - Upon success, the fetched posts are mapped to `Post` models and stored in the `posts` array.
    func fetchPosts() {
        COLLECTION_POSTS.order(by: "timestamp", descending: true).getDocuments { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let documents = snapshot?.documents else { return }
            
            self.posts = documents.compactMap({ try? $0.data(as: Post.self)})
            
        }
    }
    
}
