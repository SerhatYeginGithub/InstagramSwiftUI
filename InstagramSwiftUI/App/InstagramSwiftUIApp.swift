//
//  InstagramSwiftUIApp.swift
//  InstagramSwiftUI
//
//  Created by serhat on 14.10.2024.
//

import SwiftUI

@main
struct InstagramSwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AuthViewModel.shared)
        }
    }
}

