//
//  FeedView.swift
//  InstagramSwiftUI
//
//  Created by serhat on 14.10.2024.
//

import SwiftUI

struct FeedView: View {
    @StateObject private var vm = FeedViewModel()
    
    var body: some View {
        
        NavigationStack {
            ScrollView(showsIndicators: false){
                LazyVStack(spacing: 32){
                    ForEach(vm.posts) { post in
                        
                        FeedCell(post: post)
                    }
                }
                .padding(.top)
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: logOutButton)
            .refreshable {
                vm.fetchPosts()
            }
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
