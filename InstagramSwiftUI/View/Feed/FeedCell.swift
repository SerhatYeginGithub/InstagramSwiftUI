//
//  FeedCell.swift
//  InstagramSwiftUI
//
//  Created by serhat on 14.10.2024.
//

import SwiftUI
import Kingfisher

struct FeedCell: View {
    let post: Post
    var body: some View {
        VStack(alignment: .leading) {
            // USER INFO
            HStack {
                KFImage(URL(string: post.ownerImageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 36, height: 36)
                    .clipped()
                    .cornerRadius(18)
                
                Text(post.ownerUsername)
                    .font(.system(size: 15, weight: .semibold))
                Spacer()
            }
            .padding([.leading, .bottom], 8)
            
            // POST IMAGE
            KFImage(URL(string: post.imageUrl))
                .resizable()
                .scaledToFill()
                .frame(maxHeight: 440)
                .clipped()
            
            // ACTION BUTTONS
            actionButtons
            
            // CAPTION
            caption
        }
    }
}


private extension FeedCell {
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
        Text("\(post.likes) likes")
            .font(.system(size: 14, weight: .semibold))
            .padding(.leading, 8)
            .padding(.bottom, 2)
        HStack {
            Text(post.ownerUsername)
                .font(.system(size: 15, weight: .semibold))
            +
            Text(" " + post.caption)
                .font(.system(size: 16))
            
        }
        .padding(.horizontal, 8)
        Text("\(post.timestamp)")
            .font(.system(size: 14))
            .foregroundColor(.gray)
            .padding(.leading, 8)
            .padding(.top, 4)
    }
    
}
