//
//  UserCell.swift
//  InstagramSwiftUI
//
//  Created by serhat on 14.10.2024.
//

import SwiftUI

struct UserCell: View {
    var body: some View {
        HStack {
            Image("panda")
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipped()
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text("Panda")
                    .fontWeight(.semibold)
                Text("Serhat Yeğin")
            }
            .font(.system(size: 14))
            
            Spacer()
        }
    }
}

#Preview {
    UserCell()
}
