//
//  Notification.swift
//  InstagramSwiftUI
//
//  Created by serhat on 20.10.2024.
//

import Foundation
import FirebaseFirestore

struct Notification: Identifiable, Codable {
    @DocumentID var id: String?
    var postId: String?
    let username: String
    let profileImageUrl: String
    let timestamp: Timestamp
    let type: NotificationType
    let uid: String
    
    var isFollowed: Bool? = false
    var post: Post?
    var user: User?
}

enum NotificationType: Int, Codable{
case like
    case comment
    case follow
    
    var notificationMessage: String {
        switch self {
        case .like: return "liked your post"
        case .comment: return "commented on one your post"
        case .follow: return "started following you"
        }
    }
}

