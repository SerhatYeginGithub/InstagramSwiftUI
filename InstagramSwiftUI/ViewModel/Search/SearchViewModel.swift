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
    
    /// Fetches all users from the Firestore `COLLECTION_USERS`.
    /// The fetched users are then stored in the `users` array.
    /// - Uses Firestore's `getDocuments` method to retrieve the data.
    func fetchUsers() {
        COLLECTION_USERS.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            self.users = documents.compactMap({ try? $0.data(as: User.self)})
            
        }
    }
    
    /// Fetches filtered users from the Firestore `COLLECTION_USERS` based on the provided query.
    /// The filtered users are stored in the `filteredUsers` array.
    /// - Parameter query: The string used to filter the users by username.
    /// - Uses Firestore's `whereField` and `getDocuments` methods for filtering.
    func fetchFilteredUsers(query: String)  {
        COLLECTION_USERS
            .whereField("username", isGreaterThanOrEqualTo: query)
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
