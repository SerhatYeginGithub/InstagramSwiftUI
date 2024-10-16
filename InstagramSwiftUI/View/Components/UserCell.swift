//
//  UserCell.swift
//  InstagramSwiftUI
//
//  Created by serhat on 14.10.2024.
//

import SwiftUI
import Kingfisher

struct UserCell: View {
    let user: User
    var body: some View {
        HStack {
            KFImage(URL(string: user.profileImageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipped()
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(user.username)
                    .fontWeight(.semibold)
                Text(user.fullname)
            }
            .font(.system(size: 14))
            
            Spacer()
        }
    }
}

//#Preview {
//    UserCell()
//}
