//
//  MainTabView.swift
//  InstagramSwiftUI
//
//  Created by serhat on 14.10.2024.
//

import SwiftUI

struct MainTabView: View {
    let user: User
    @State private var selectedIndex = 0
    var body: some View {
        
        TabView (selection: $selectedIndex) {
            FeedView()
                .tabItem { Image.house }
                .tag(0)
            SearchView()
                .tabItem { Image.search }
                .tag(1)
            UploadPostView()
                .tabItem { Image.plusSquare }
                .tag(2)
            NotificationsView()
                .tabItem { Image.heart }
                .tag(3)
            ProfileView(user: user)
                .tabItem { Image.person }
                .tag(4)
        }
        .accentColor(Color(.label))
        
    }
}
