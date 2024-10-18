//
//  FeedViewModel.swift
//  InstagramSwiftUI
//
//  Created by serhat on 17.10.2024.
//

import Foundation


final class FeedViewModel: ObservableObject {
    @Published var posts: [Post] = []
    
    init() {
        fetchPosts()
    }
    
    func fetchPosts() {
        COLLECTION_POSTS.getDocuments { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let documents = snapshot?.documents else { return }
            
            self.posts = documents.compactMap({ try? $0.data(as: Post.self)})
            
        }
    }
    
}
