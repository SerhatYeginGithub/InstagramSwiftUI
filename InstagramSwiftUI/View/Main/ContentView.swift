//
//  ContentView.swift
//  InstagramSwiftUI
//
//  Created by serhat on 14.10.2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var authvm: AuthViewModel
    var body: some View {
        Group {
            if authvm.userSession == nil {
                LoginView()
            } else {
                if let user = authvm.currentUser {
                    MainTabView(user: user)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
