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
    
    /// Follows the user with the specified UID.
    /// - Parameter uid: The UID of the user to follow.
    /// - Throws: An error if the follow operation fails.
    func follow(uid: String) async throws {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        
        do {
            // Add the user to the current user's following list
            try await COLLECTION_FOLLOWING.document(currentUid)
                .collection(COLLECTION_USER_FOLLOWING).document(uid).setData([:])
            
            // Add the current user to the other user's followers list
            try await COLLECTION_FOLLOWERS.document(uid)
                .collection(COLLECTION_USER_FOLLOWERS).document(currentUid).setData([:])
        } catch {
            throw error
        }
    }
    
    /// Unfollows the user with the specified UID.
    /// - Parameter uid: The UID of the user to unfollow.
    /// - Throws: An error if the unfollow operation fails.
    func unfollow(uid: String) async throws {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        
        do {
            // Remove the user from the current user's following list
            try await COLLECTION_FOLLOWING.document(currentUid)
                .collection(COLLECTION_USER_FOLLOWING).document(uid).delete()
            
            // Remove the current user from the other user's followers list
            try await COLLECTION_FOLLOWERS.document(uid)
                .collection(COLLECTION_USER_FOLLOWERS).document(currentUid).delete()
        } catch {
            throw error
        }
    }
    
    /// Checks if the current user is following the user with the specified UID.
    /// - Parameter uid: The UID of the user to check.
    /// - Returns: A boolean indicating whether the current user is following the other user.
    /// - Throws: An error if the check operation fails.
    func checkIfUserIsFollowed(uid: String) async throws -> Bool {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return false }
        
        do {
            // Get the document for the current user's following list
            let documentSnapshot = try await COLLECTION_FOLLOWING.document(currentUid)
                .collection(COLLECTION_USER_FOLLOWING).document(uid).getDocument()
            
            // Return whether the user is followed
            return documentSnapshot.exists
        } catch {
            return false
        }
    }
}
