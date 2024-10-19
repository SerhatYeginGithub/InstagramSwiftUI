//
//  Comment.swift
//  InstagramSwiftUI
//
//  Created by serhat on 19.10.2024.
//

import FirebaseFirestore

struct Comment: Identifiable, Codable {
    @DocumentID var id: String?
    let username: String
    let postOwnerUid: String
    let profileImageUrl: String
    let commentText: String
    let timestamp: Timestamp
    let uid: String
}
