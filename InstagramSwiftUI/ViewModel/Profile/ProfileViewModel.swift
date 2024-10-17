//
//  ProfileViewModel.swift
//  InstagramSwiftUI
//
//  Created by serhat on 17.10.2024.
//

import Foundation

final class ProfileViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
        checkIfUserisFollowed()
    }
    
    func follow() {
        guard let uid = user.id else { return }
        UserService.shared.follow(uid: uid) { [weak self] error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self?.user.isFollowed = true
        }
    }
    
    func unfollow() {
        guard let uid = user.id else { return }
        UserService.shared.unfollow(uid: uid) { [weak self] error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self?.user.isFollowed = false 
        }
    }
    
    func checkIfUserisFollowed() {
        guard !user.isCurrentUser else { return }
        guard let uid = user.id else { return }
        
        UserService.shared.checkIfUserIsFollowed(uid: uid) { [weak self] isFollowed in
            self?.user.isFollowed = isFollowed
        }
    }
}
