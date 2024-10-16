//
//  SearchViewModel.swift
//  InstagramSwiftUI
//
//  Created by serhat on 16.10.2024.
//

import Firebase

final class SearchViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var filteredUsers: [User] = []
    
    
    func fetchUsers() {
        COLLECTION_USERS.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            self.users = documents.compactMap({ try? $0.data(as: User.self)})
    
        }
    }
    
    func fetchFilteredUsers(query: String)  {
        COLLECTION_USERS
            .whereField("username", isGreaterThanOrEqualTo: query)
            .whereField("username", isLessThanOrEqualTo: query)
            .limit(to: 10)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error fetching users: \(error.localizedDescription)")
                    return
                }
                guard let documents = snapshot?.documents else { return }
                self.filteredUsers = documents.compactMap({ try? $0.data(as: User.self)})
            }
    }
    
}
