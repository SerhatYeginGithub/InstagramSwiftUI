//
//  LoginView.swift
//  InstagramSwiftUI
//
//  Created by serhat on 15.10.2024.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject private var vm : AuthViewModel
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.purple, .blue], startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                        .frame(height: 45)
                    logoView
                    VStack(spacing: 20){
                        // email field
                        CustomTextField(placeholder: "Email", icon: "envelope", tf: $email)
                            .padding(.horizontal, 32)
                        // password field
                        CustomSecureTextField(placeholder: "Password", icon: "lock", tf: $password)
                            .padding(.horizontal, 32)
                        
                        //forgot password
                        forgotPasswordView
                        // sign In
                        signInButton
                    }
                    
                    Spacer()
                    
                    // go to sign up
                    goToSignUp
                    
                }
            }
            
        }
        
    }
}

#Preview {
    LoginView()
}

private extension LoginView {
    @ViewBuilder
    var logoView: some View {
        Image("instagram_logo")
            .resizable()
            .renderingMode(.template)
            .foregroundColor(.white)
            .scaledToFit()
            .frame(width: 220, height: 100)
    }
    var forgotPasswordView: some View {
        HStack {
            Spacer()
            Button("Forgot password ?") {
                
            }
            .font(.system(size: 13, weight: .semibold))
            .foregroundColor(.white)
            .padding(.trailing, 28)
        }
    }
    
    var signInButton: some View {
        Button("Sign In") {
            vm.login(withEmail: email, password: password)
        }
        .font(.headline)
        .foregroundColor(.white)
        .frame(width: 360, height: 50)
        .background(Color(.systemPurple))
        .clipShape(Capsule())
        .padding()
    }
    
    var goToSignUp: some View {
        NavigationLink(destination:
                        RegisterView()
            .navigationBarHidden(true)
                       , label: {
            HStack {
                Text("Don't have an account?")
                Text("Sign Up")
                    .fontWeight(.semibold)
            }
            .foregroundColor(.white)
            .font(.system(size: 14))
        })
        .padding(.bottom, 38)
    }
    
}
