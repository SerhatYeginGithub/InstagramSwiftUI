//
//  ImageUploader.swift
//  InstagramSwiftUI
//
//  Created by serhat on 16.10.2024.
//

import UIKit
import FirebaseStorage

enum UploadType {
    case profile
    case post
    
    var filePath: StorageReference {
        let fileName = NSUUID().uuidString
        switch self {
        case .profile:
            return Storage.storage().reference(withPath: "/profile_images/\(fileName)")
        case.post:
            return Storage.storage().reference(withPath: "/post_images/\(fileName)")
        }
    }
}


final class ImageUploader {
    
    /// Uploads the provided image to Firebase Storage and returns the download URL as a string.
        /// - Parameter image: The `UIImage` to be uploaded.
        /// - Parameter completion: A completion handler that returns the download URL of the uploaded image as a `String?`.
        /// - Compresses the image to JPEG format with 50% quality before uploading.
        /// - Uses Firebase Storage to store the image in the `/profile_images/` path with a unique filename.
    static func uploadImage(image: UIImage, type: UploadType, completion: @escaping(String?)-> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        let ref = type.filePath
        ref.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("DEBUG: Failed to upload image \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            ref.downloadURL { url, _ in
                guard let imageUrl = url?.absoluteString else { return }
                completion(imageUrl)
                print("Successfully image uploaded...")
            }
        }
    }
}
