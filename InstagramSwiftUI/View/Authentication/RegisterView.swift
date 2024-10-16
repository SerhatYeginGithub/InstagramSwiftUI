//
//  RegisterView.swift
//  InstagramSwiftUI
//
//  Created by serhat on 15.10.2024.
//

import SwiftUI

struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var username = ""
    @State private var fullname = ""
    @State private var isImagePicker = false
    @StateObject private var imagePicker = ImagePicker()
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var vm: AuthViewModel
    
    var body: some View {
        
        ZStack {
            LinearGradient(colors: [.purple, .blue], startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer().frame(height: 20)
                plusPhotoButton
                customTextFieldsView
                signUpButton
                Spacer()
                goToSignIn
            }
            
        }
        .photosPicker(isPresented: $isImagePicker, selection: $imagePicker.selectedImage)
    }
}

#Preview {
    RegisterView()
}

private extension RegisterView {
    
    var plusPhotoButton: some View {
        Button(action: {
            isImagePicker.toggle()
        }, label: {
            if let image = imagePicker.postImage {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 180, height: 180)
                    .clipShape(Circle())
            } else {
                Image("plus_photo")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .scaledToFit()
                    .frame(width: 180, height: 180)
            }
        })
        .padding(.bottom)
    }
    
    var customTextFieldsView: some View {
        VStack(spacing: 20){
            CustomTextField(placeholder: "Email", icon: "envelope", tf: $email)
            CustomTextField(placeholder: "Username", icon: "person", tf: $username)
            CustomTextField(placeholder: "Full Name", icon: "person", tf: $fullname)
            CustomSecureTextField(placeholder: "Password", icon: "lock", tf: $password)
        }
        .padding(.horizontal, 32)
    }
    
    var signUpButton: some View {
        Button("Sign Up") {
            vm.register(withEmail: email, password: password, image: imagePicker.uiImage, fullname: fullname, username: username)
        }
        .font(.headline)
        .foregroundColor(.white)
        .frame(width: 360, height: 50)
        .background(Color(.systemPurple))
        .clipShape(Capsule())
        .padding()
    }
    
    var goToSignIn: some View {
        Button(action: {
            dismiss()
        }, label: {
            HStack {
                Text("Already have an account?")
                Text("Sign In")
                    .fontWeight(.semibold)
            }
            .foregroundColor(.white)
            .font(.system(size: 14))
        })
        .padding(.bottom, 38)
    }
    
}
