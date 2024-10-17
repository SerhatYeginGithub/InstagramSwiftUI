//
//  ProfileActionButtonView.swift
//  InstagramSwiftUI
//
//  Created by serhat on 15.10.2024.
//

import SwiftUI

struct ProfileActionButtonView: View {
    @ObservedObject var vm: ProfileViewModel
    var isFollowed: Bool { return vm.user.isFollowed ?? false }
    
    var body: some View {
        if vm.user.isCurrentUser {
            HStack {
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Edit Profile")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(Color(.label))
                        .frame(width: 360, height: 32)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding(.top)
                })
                Spacer()
            }
        } else {
            HStack {
                Spacer()
                Button(action: {isFollowed ? vm.unfollow() : vm.follow() }, label: {
                    Text(isFollowed ? "Following" : "Follow")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(isFollowed ? Color(.label) : .white)
                        .frame(width: 172, height: 32)
                        .background(isFollowed ? Color(.systemBackground) : Color(.systemBlue))
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: isFollowed ? 1 : 0)
                        )
                        
                }).cornerRadius(3)
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Message")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(Color(.label))
                        .frame(width: 172, height: 32)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    
                })
                
                Spacer()
            }
        }
    }
}

