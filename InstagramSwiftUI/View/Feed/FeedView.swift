//
//  FeedView.swift
//  InstagramSwiftUI
//
//  Created by serhat on 14.10.2024.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        
        NavigationStack {
            ScrollView(showsIndicators: false){
                LazyVStack(spacing: 32){
                    ForEach(0...20, id: \.self) { _ in
                        FeedCell()
                    }
                }
                .padding(.top)
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: logOutButton)
        }
    }
}

#Preview {
    FeedView()
}
private extension FeedView {
    
    var logOutButton: some View {
        Button("Log out") {
            AuthViewModel.shared.signOut()
        }
        .foregroundColor(Color(.label))
        .fontWeight(.semibold)
    }

}
