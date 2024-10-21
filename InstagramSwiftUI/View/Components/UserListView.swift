//
//  UserListView.swift
//  InstagramSwiftUI
//
//  Created by serhat on 14.10.2024.
//

import SwiftUI

struct UserListView: View {
    @ObservedObject var vm: SearchViewModel
   
    var body: some View {
        ScrollView {
            LazyVStack(){
                ForEach(vm.filteredUsers) { user in
                    NavigationLink(destination: LazyView(build: ProfileView(user: user))) {
                        UserCell(user: user)
                            .padding(.leading)
                    }
                }
            }
        }
    }
}

