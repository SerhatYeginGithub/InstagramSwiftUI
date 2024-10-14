//
//  FeedCell.swift
//  InstagramSwiftUI
//
//  Created by serhat on 14.10.2024.
//

import SwiftUI

struct FeedCell: View {
    var body: some View {
        VStack(alignment: .leading) {
            // USER INFO
            userInfo
            
            // POST IMAGE
            postImageView
            
            // ACTION BUTTONS
            actionButtons
            
            // CAPTION
            caption
        }
    }
}

#Preview {
    FeedCell()
}


private extension FeedCell {
    @ViewBuilder
    var userInfo: some View {
        HStack {
            Image("panda")
                .resizable()
                .scaledToFill()
                .frame(width: 36, height: 36)
                .clipped()
                .cornerRadius(18)
            
            Text("Panda")
                .font(.system(size: 15, weight: .semibold))
            Spacer()
        }
        .padding([.leading, .bottom], 8)
    }
    @ViewBuilder
    var postImageView: some View {
        Image("tiger")
            .resizable()
            .scaledToFill()
            .frame(maxHeight: 440)
            .clipped()
    }
    @ViewBuilder
    var actionButtons: some View {
        HStack(spacing: 16) {
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: { Image(systemName: "heart")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 20, height: 20)
                    .font(.system(size: 20))
            })
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: { Image(systemName: "bubble.right")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 20, height: 20)
                    .font(.system(size: 20))
            })
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: { Image(systemName: "paperplane")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 20, height: 20)
                    .font(.system(size: 20))
            })
            
            
        }
        .foregroundColor(.black)
        .padding([.leading, .top], 8)
    }
    
    @ViewBuilder
    var caption: some View {
        Text("3 likes")
            .font(.system(size: 14, weight: .semibold))
            .padding(.leading, 8)
            .padding(.bottom, 2)
        HStack {
            Text("Panda")
                .font(.system(size: 15, weight: .semibold))
            +
            Text(" Hit me baby one more time! :)")
                .font(.system(size: 16))
            
        }
        .padding(.horizontal, 8)
        Text("2d")
            .font(.system(size: 14))
            .foregroundColor(.gray)
            .padding(.leading, 8)
            .padding(.top, 4)
    }
    
}
