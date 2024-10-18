//
//  UploadViewModel.swift
//  InstagramSwiftUI
//
//  Created by serhat on 17.10.2024.
//

import SwiftUI
import Firebase

typealias FirestoreCompletion = (Bool)->()

final class UploadViewModel: ObservableObject {
    
    /// Uploads a post to Firestore with the given caption and image.
    /// - Parameters:
    ///   - caption: The caption text for the post.
    ///   - image: The UIImage that will be uploaded as part of the post.
    ///   - completion: A completion handler that returns a boolean indicating success or failure.
    /// - The function first uploads the image to Firebase Storage, retrieves the image URL, and then creates a new post document in Firestore with the caption, image URL, and user details.
    func uploadPost(caption: String, image: UIImage?, completion: @escaping FirestoreCompletion) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        guard let image = image else {
            completion(false)
            return
        }
        
        ImageUploader.uploadImage(image: image, type: .post) { imageUrl in
            guard let imageUrl = imageUrl else {
                completion(false)
                return
            }
            
            let data = [
                "caption": caption,
                "timestamp": Timestamp(date: Date()),
                "likes": 0,
                "imageUrl": imageUrl,
                "ownerUid": user.id ?? "",
                "ownerImageUrl": user.profileImageUrl,
                "ownerUsername": user.username
            ] as [String: Any]
            
            COLLECTION_POSTS.addDocument(data: data) { error in
                if let error = error {
                    print(error.localizedDescription)
                    completion(false)
                    return
                }
                print("DEBUG: Uploaded post.")
                completion(true)
            }
            
        }
    }
}
