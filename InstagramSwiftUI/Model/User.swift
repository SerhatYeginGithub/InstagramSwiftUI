//
//  User.swift
//  InstagramSwiftUI
//
//  Created by serhat on 16.10.2024.
//

import FirebaseFirestore
import FirebaseAuth
struct User: Codable, Identifiable {
    
    let username: String
    let fullname: String
    let email: String
    let profileImageUrl: String
    @DocumentID var id: String?
    var isFollowed: Bool? = false
    var isCurrentUser: Bool {
        return Auth.auth().currentUser?.uid == id
    }
}
