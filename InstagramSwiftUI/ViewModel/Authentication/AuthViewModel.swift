//
//  AuthViewModel.swift
//  InstagramSwiftUI
//
//  Created by serhat on 16.10.2024.
//

import SwiftUI
import Firebase
import FirebaseAuth

final class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    static let shared = AuthViewModel()
    
    private init() {
        self.userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    
    /// Logs in the user with the provided email and password.
    /// - Parameters:
    ///   - email: The user's email.
    ///   - password: The user's password.
    /// - If login is successful, the user session is updated and the current user is fetched from Firestore.
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
            print("Succesfully logined user...")
        }
    }
    
    
    /// Registers a new user with the provided email, password, profile image, full name, and username.
    /// - Parameters:
    ///   - email: The user's email.
    ///   - password: The user's password.
    ///   - image: The user's profile image.
    ///   - fullname: The user's full name.
    ///   - username: The user's chosen username.
    /// - Uploads the user's profile image, creates a new Firebase Auth user, and saves user data to Firestore.
    func register(withEmail email: String, password: String, image: UIImage?, fullname: String, username: String) {
        guard let image = image else { return }
        ImageUploader.uploadImage(image: image, type: .profile) { [weak self] imageUrl in
            guard let imageUrl = imageUrl else { return }
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                    print(error)
                    return
                }
                guard let user = result?.user else { return }
                print("Successfully registered user...")
                
                let data = [
                    "email": email,
                    "username": username,
                    "fullname": fullname,
                    "profileImageUrl": imageUrl,
                    "uid": user.uid
                ]
                
                Firestore.firestore().collection("users").document(user.uid).setData(data) {
                    error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    print("Successfully uploaded user data...")
                    self?.userSession = user
                    self?.fetchUser()
                }
            }
        }
        
    }
    
    
    /// Signs out the currently logged-in user.
    /// - Resets the `userSession` and `currentUser` to nil after successful sign-out.
    func signOut() {
        guard (try? Auth.auth().signOut()) != nil else {return}
        self.userSession = nil
        self.currentUser = nil
    }
    
    
    /// Resets the user's password.
    /// Currently just a placeholder function for password reset functionality.
    func resetPassword() {
        print("Reset Password")
    }
    
    /// Fetches the current user data from Firestore based on the user session's UID.
    /// - Updates the `currentUser` with the data fetched from Firestore.
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            guard let user = try? snapshot?.data(as: User.self) else { return }
            
            self.currentUser = user
        }
    }
    
}
