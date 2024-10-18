//
//  Post.swift
//  InstagramSwiftUI
//
//  Created by serhat on 17.10.2024.
//

import FirebaseFirestore
import FirebaseAuth

struct Post: Identifiable, Codable {
    @DocumentID var id: String?
    let ownerUid: String
    let ownerUsername: String
    let caption: String
    var likes: Int
    let imageUrl: String
    let timestamp: Timestamp
    let ownerImageUrl: String
    
    var didLike: Bool? = false
}
