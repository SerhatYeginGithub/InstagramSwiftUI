//
//  ImageUploader.swift
//  InstagramSwiftUI
//
//  Created by serhat on 16.10.2024.
//

import UIKit
import FirebaseStorage

final class ImageUploader {
    static func uploadImage(image: UIImage, completion: @escaping(String?)-> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        let fileName = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(fileName)")
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
