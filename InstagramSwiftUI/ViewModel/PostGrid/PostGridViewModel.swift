//
//  PostGridViewModel.swift
//  InstagramSwiftUI
//
//  Created by serhat on 18.10.2024.
//

import Foundation

enum PostGridConfig {
    
    case explore
    case profile(String?)
}

final class PostGridViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    let config: PostGridConfig
    
    
    /// Initializes the view model with a given configuration.
    /// - Parameter config: Determines whether to fetch posts for the explore page or a specific user's profile.
    /// - The `fetchPosts(forConfig:)` method is called immediately upon initialization.
    init(config: PostGridConfig) {
        self.config = config
        fetchPosts(forConfig: config)
    }
    
    /// Fetches posts based on the provided configuration.
    /// - Parameter config: The configuration that determines whether to fetch explore page posts or user-specific posts.
    /// - Uses `fetchExplorePagePosts` for explore and `fetchUserPosts(forUid:)` for user-specific post fetching.
    func fetchPosts(forConfig config: PostGridConfig) {
        switch config {
        case .explore:
            fetchExplorePagePosts()
        case .profile(let uid):
            fetchUserPosts(forUid: uid)
            
        }
    }
    
    
    /// Fetches posts for the explore page from Firestore.
    /// - Retrieves all posts from the `COLLECTION_POSTS` collection and maps them into the `posts` array.
    func fetchExplorePagePosts() {
        COLLECTION_POSTS.getDocuments { snapshot, error in
            if let _ = error { return }
            guard let documents = snapshot?.documents else { return }
            
            self.posts = documents.compactMap({ try? $0.data(as: Post.self) })
        }
    }
    
    
    /// Fetches posts for a specific user based on their `uid`.
    /// - Parameter uid: The user ID for which posts will be fetched.
    /// - Queries Firestore for posts where the `ownerUid` matches the given `uid`.
    func fetchUserPosts(forUid uid: String?) {
        guard let uid = uid else { return }
        COLLECTION_POSTS.whereField("ownerUid", isEqualTo: uid).getDocuments { snapshot, error in
            if let _ = error { return }
            guard let documents = snapshot?.documents else { return }
            
            self.posts = documents.compactMap({ try? $0.data(as: Post.self) })
        }
    }
}
