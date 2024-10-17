//
//  UserService.swift
//  InstagramSwiftUI
//
//  Created by serhat on 17.10.2024.
//

import Foundation
import Firebase

final class UserService {
    
    static let shared = UserService()
    
    private init() {}
    
    func follow(uid: String, completion: ((Error?)-> Void)?) {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        
        COLLECTION_FOLLOWING.document(currentUid)
            .collection("user-following").document(uid).setData([:]) { _ in
                COLLECTION_FOLLOWERS.document(uid).collection("user-followers")
                    .document(currentUid).setData([:],completion: completion)
            }
    }
    
    func unfollow(uid: String, completion: ((Error?)-> Void)?) {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following")
            .document(uid).delete { _ in
                COLLECTION_FOLLOWERS.document(uid).collection("user-followers")
                    .document(currentUid).delete(completion: completion)
            }
    }
    
    func checkIfUserIsFollowed(uid: String, completion: @escaping ((Bool)-> Void)) {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).getDocument { snapshot, _ in
            guard let isFollowed = snapshot?.exists else { return }
            completion(isFollowed)
        }
    }
}
