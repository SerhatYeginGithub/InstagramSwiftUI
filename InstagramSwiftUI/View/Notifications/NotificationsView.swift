//
//  NotificationsView.swift
//  InstagramSwiftUI
//
//  Created by serhat on 14.10.2024.
//

import SwiftUI

struct NotificationsView: View {
    @StateObject private var vm = NotificationsViewModel()
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 20){
                    ForEach(vm.notifications) { notification in
                        NotificationCell(vm: NotificationCellViewModel(notification: notification))
                            .padding(.top)
                    }
                }
            }
            .navigationTitle("Notifications")
        }
    }
}


#Preview {
    NotificationsView()
}
