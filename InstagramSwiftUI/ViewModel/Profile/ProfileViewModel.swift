//
//  ProfileViewModel.swift
//  InstagramSwiftUI
//
//  Created by serhat on 17.10.2024.
//

import Foundation

@MainActor
final class ProfileViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
        Task {
            await checkIfUserisFollowed()
        }
    }
    
    /// Follows the user asynchronously.
    /// Updates the `isFollowed` property of the user upon success.
    func follow() async {
        guard let uid = user.id else { return }
        
        do {
            try await UserService.shared.follow(uid: uid)
            user.isFollowed = true
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /// Unfollows the user asynchronously.
    /// Updates the `isFollowed` property of the user upon success.
    func unfollow() async {
        guard let uid = user.id else { return }
        
        do {
            try await UserService.shared.unfollow(uid: uid)
            user.isFollowed = false
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /// Checks if the user is followed asynchronously.
    /// Updates the `isFollowed` property of the user if applicable.
    func checkIfUserisFollowed() async {
        guard !user.isCurrentUser else { return }
        guard let uid = user.id else { return }
        
        do {
            let isFollowed = try await UserService.shared.checkIfUserIsFollowed(uid: uid)
            user.isFollowed = isFollowed
        } catch {
            print(error.localizedDescription)
        }
    }
}
