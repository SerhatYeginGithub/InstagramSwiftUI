//
//  UploadPostView.swift
//  InstagramSwiftUI
//
//  Created by serhat on 14.10.2024.
//

import SwiftUI

struct UploadPostView: View {
    
    @State private var imagePickerPresented = false
    @State private var caption = ""
    @StateObject private var imagePicker = ImagePicker()
    @StateObject private var vm = UploadViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if imagePicker.postImage == nil {
                    plusPhotoButton
                } else {
                    postProcessView
                }
                Spacer()
            }
            .navigationTitle("New Post")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: cancelButton)
        }
        .photosPicker(isPresented: $imagePickerPresented, selection: $imagePicker.selectedImage)
        
    }
}

private extension UploadPostView {
    var plusPhotoButton: some View {
        Button(action: { imagePickerPresented.toggle()}, label: {
            Image("plus_photo")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.black)
                .scaledToFill()
                .frame(width: 180, height: 180)
                .clipped()
                .padding(.top, 56)
            
        })
    }
    
    @ViewBuilder
    var postProcessView: some View {
        HStack(alignment: .top){
            if let image = imagePicker.postImage {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 96, height: 96)
                    .clipped()
                TextField("Enter your caption...",text: $caption,axis: .vertical)
            }
        }.padding()
        
        shareButton
        
            .padding()
    }
    
    var shareButton: some View {
        Button(action: {
            vm.uploadPost(caption: caption, image: imagePicker.uiImage) { success in
                if success {
                    clear()
                }
               
            }
            
        }, label: {
            Text("Share")
                .font(.system(size: 16, weight: .semibold))
                .frame(width: 360, height: 45)
                .background(Color(.systemBlue))
                .foregroundColor(.white)
                .cornerRadius(5)
        })
    }
    
    var cancelButton: some View {
        Button("Cancel") {
            clear()
        }
        .fontWeight(.semibold)
        .disabled(imagePicker.postImage == nil ? true : false)
    }
    
    func clear() {
        caption = ""
        imagePicker.uiImage = nil
        imagePicker.postImage = nil
        imagePicker.selectedImage = nil
    }
}


#Preview {
    UploadPostView()
}
