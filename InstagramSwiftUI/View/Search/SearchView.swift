//
//  SearchView.swift
//  InstagramSwiftUI
//
//  Created by serhat on 14.10.2024.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @StateObject private var vm = SearchViewModel()
    var body: some View {
        NavigationStack {
            ScrollView {
                ZStack {
                    if searchText.isEmpty {
                        PostGridView()
                    }
                    else {
                        UserListView(vm: vm)
                    }
                    
                }
            }
            .searchable(text: $searchText, prompt: "Search for a user")
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: searchText) { oldValue, newValue in
                if !newValue.isEmpty, newValue.count >= 3 {
                    vm.fetchFilteredUsers(query: newValue)
                } else {
                    vm.filteredUsers.removeAll()
                }
            }
        }
        
    }
}

#Preview {
    SearchView()
}
