//
//  ProfileHeaderView.swift
//  InstagramSwiftUI
//
//  Created by serhat on 15.10.2024.
//

import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {
    @ObservedObject var vm: ProfileViewModel
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                KFImage(URL(string: vm.user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .padding(.leading, 8)
                Spacer()
                HStack(spacing: 16){
                    UserStatusView(value: 12, title: "Post")
                    UserStatusView(value: 13, title: "Followers")
                    UserStatusView(value: 14, title: "Following")
                }
                Spacer()
                
            }
            userInfo
            ProfileActionButtonView(vm: vm)
        }
    }
}

//#Preview {
//    ProfileHeaderView()
//}

private extension ProfileHeaderView {

    @ViewBuilder
    var userInfo: some View {
        Text(vm.user.username)
            .font(.system(size: 15, weight: .semibold))
            .padding(.leading)
            .padding(.top, 2)
        
        Text(vm.user.fullname)
            .font(.system(size: 15))
            .padding(.leading)
            .padding(.top, 1)
    }
    
}

