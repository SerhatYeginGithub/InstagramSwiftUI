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
    
    func register(withEmail email: String, password: String, image: UIImage?, fullname: String, username: String) {
        guard let image = image else { return }
        ImageUploader.uploadImage(image: image) { [weak self] imageUrl in
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
    
    func signOut() {
        guard (try? Auth.auth().signOut()) != nil else {return}
        self.userSession = nil
        self.currentUser = nil
    }
    
    func resetPassword() {
        print("Reset Password")
    }
    
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            guard let user = try? snapshot?.data(as: User.self) else { return }
            
            self.currentUser = user
        }
    }
    
}
