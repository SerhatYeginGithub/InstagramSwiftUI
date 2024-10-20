//
//  NotificationCell.swift
//  InstagramSwiftUI
//
//  Created by serhat on 14.10.2024.
//

import SwiftUI
import Kingfisher

struct NotificationCell: View {
    @ObservedObject private var vm: NotificationCellViewModel
    
    init(vm: NotificationCellViewModel) {
        self.vm = vm
    }
    
    var isFollowed: Bool { vm.notification.isFollowed ?? false }
    
    var body: some View {
        HStack {
            if let user = vm.notification.user {
                NavigationLink(destination: ProfileView(user: user)) {
                    KFImage(URL(string: vm.notification.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    notificationInfo
                }
             
            }
            Spacer()
            
            if vm.notification.type != .follow {
                if let post = vm.notification.post {
                    NavigationLink(destination: FeedCell(vm: FeedCellViewModel(post: post))) {
                        KFImage(URL(string: post.imageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipped()
                    }
               
                }
            } else {
                // FOLLOW BUTTON
                followButton
            }
        }
        .padding(.horizontal)
    }
}



private extension NotificationCell {
    
    var followButton: some View {
            Button(action: {Task {await isFollowed ? vm.unfollow() : vm.follow() } }, label: {
                Text(isFollowed ? "Following" : "Follow")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(isFollowed ? Color(.label) : .white)
                    .frame(width: 100, height: 32)
                    .background(isFollowed ? Color(.systemBackground) : Color(.systemBlue))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: isFollowed ? 1 : 0)
                    )
                    
            })
    }
    
    @ViewBuilder
    var notificationInfo: some View {
     
        Text(vm.notification.username)
            .font(.system(size: 14, weight: .semibold))
        +
        Text(" " + vm.notification.type.notificationMessage)
            .font(.system(size: 15))
        
    }
    
}
