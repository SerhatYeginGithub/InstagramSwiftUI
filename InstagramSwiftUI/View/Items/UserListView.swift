//
//  UserListView.swift
//  InstagramSwiftUI
//
//  Created by serhat on 14.10.2024.
//

import SwiftUI

struct UserListView: View {
    var body: some View {
        ScrollView {
            LazyVStack(){
                ForEach(0..<20) { _ in
                    UserCell()
                        .padding(.leading)
                }
            }
        }
    }
}

#Preview {
    UserListView()
}
