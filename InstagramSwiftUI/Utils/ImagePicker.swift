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
    
    @MainActor
    func loadImage(fromItem item : PhotosPickerItem?) async {
        guard let item = item else {return}
        
        guard let data = try? await item.loadTransferable(type: Data.self) else {return}
        
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.postImage = Image(uiImage: uiImage)
    }
    
}
