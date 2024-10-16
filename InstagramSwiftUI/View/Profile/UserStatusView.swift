//
//  UserStatusView.swift
//  InstagramSwiftUI
//
//  Created by serhat on 15.10.2024.
//

import SwiftUI

struct UserStatusView: View {
    let value: Int
    let title: String
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 2){
            Text("\(value)")
                .font(.system(size: 15, weight: .semibold))
                .lineLimit(nil)
                .frame(width: 60)
                .multilineTextAlignment(.center)
            Text(title)
                .font(.system(size: 15, weight: .medium))
        }
    }
}


#Preview {
    UserStatusView(value: 12, title: "Followers")
}

