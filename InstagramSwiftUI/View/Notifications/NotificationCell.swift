//
//  NotificationCell.swift
//  InstagramSwiftUI
//
//  Created by serhat on 14.10.2024.
//

import SwiftUI

struct NotificationCell: View {
    
    @State private var showPostImage = false
    
    var body: some View {
        HStack {
            // NOTIFICATION INFO
            notificationInfo
            Spacer()
            
            if showPostImage {
                // POST IMAGE
                postImage
            } else {
                // FOLLOW BUTTON
                followButton
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    NotificationCell()
}

private extension NotificationCell {
    
    var postImage: some View {
        Image("tiger")
            .resizable()
            .scaledToFill()
            .frame(width: 40, height: 40)
            .clipped()
    }
    
    var followButton: some View {
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
            Text("Follow")
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
                .background(Color(.systemBlue))
                .foregroundColor(.white)
                .font(.system(size: 14, weight: .semibold))
                .clipShape(Capsule())
        })
    }
    
    @ViewBuilder
    var notificationInfo: some View {
        Image("tiger")
            .resizable()
            .scaledToFill()
            .frame(width: 40, height: 40)
            .clipShape(Circle())
        Text("Tiger")
            .font(.system(size: 14, weight: .semibold))
        +
        Text(" liked one of your posts.")
            .font(.system(size: 15))
        
    }
}
