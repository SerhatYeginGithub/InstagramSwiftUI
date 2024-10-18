//
//  ImagePicker.swift
//  InstagramSwiftUI
//
//  Created by serhat on 15.10.2024.
//

import SwiftUI
import PhotosUI

final class ImagePicker: ObservableObject {
    
    @Published var selectedImage: PhotosPickerItem? {
        didSet {Task { await loadImage(fromItem: selectedImage) }}
    }
    
    @Published var postImage: Image?
    @Published var uiImage: UIImage?
    
    
    /// Loads an image from a `PhotosPickerItem` and updates the view model with the loaded image.
    /// - Parameter item: The selected `PhotosPickerItem` from the Photos library.
    /// - This function is marked as `@MainActor` to ensure UI updates occur on the main thread.
    /// - Uses `async/await` to load the image data and handle asynchronous tasks.
    @MainActor
    func loadImage(fromItem item : PhotosPickerItem?) async {
        guard let item = item else {return}
        
        guard let data = try? await item.loadTransferable(type: Data.self) else {return}
        
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.postImage = Image(uiImage: uiImage)
    }
    
}
