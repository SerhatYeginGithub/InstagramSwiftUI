//
//  ProfileView.swift
//  InstagramSwiftUI
//
//  Created by serhat on 14.10.2024.
//

import SwiftUI

struct ProfileView: View {
    let user: User
    @ObservedObject var vm: ProfileViewModel
    
    init(user: User) {
        self.user = user
        self.vm = ProfileViewModel(user: self.user)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32){
                    ProfileHeaderView(vm: vm)
                    PostGridView(configType: .profile(user.id))
                }
                .padding(.top)
            }
        }
    }
}


