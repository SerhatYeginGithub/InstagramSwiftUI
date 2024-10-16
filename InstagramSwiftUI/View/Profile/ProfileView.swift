//
//  ProfileView.swift
//  InstagramSwiftUI
//
//  Created by serhat on 14.10.2024.
//

import SwiftUI

struct ProfileView: View {
    let user: User
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32){
                    ProfileHeaderView(user: user)
                    PostGridView()
                }
                .padding(.top)
            }
           
            
        }
    }
}

//#Preview {
//    ProfileView()
//}


