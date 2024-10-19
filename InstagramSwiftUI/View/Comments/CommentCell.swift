//
//  CommentCell.swift
//  InstagramSwiftUI
//
//  Created by serhat on 19.10.2024.
//

import SwiftUI
import Kingfisher


struct CommentCell: View {
    let comment: Comment
    
    var body: some View {
        HStack {
            KFImage(URL(string: comment.profileImageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 36, height: 36)
                .clipShape(Circle())
            Text(comment.username)
                .font(.system(size: 14, weight: .semibold))
            +
            Text(" " + comment.commentText)
                .font(.system(size: 14))
            
            Text("\(comment.timestamp)")
                .foregroundColor(.gray)
                .font(.system(size: 12))
                .padding(.trailing)
            
        }
        .padding(.horizontal)
    }
}

