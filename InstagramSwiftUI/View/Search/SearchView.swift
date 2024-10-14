//
//  SearchView.swift
//  InstagramSwiftUI
//
//  Created by serhat on 14.10.2024.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    var body: some View {
        NavigationStack {
            ScrollView {
                ZStack {
                    if searchText.isEmpty {
                        PostGridView()
                    }
                    else {
                        UserListView()
                    }
                    
                }
            }
            .searchable(text: $searchText, prompt: "Search for a user")
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

#Preview {
    SearchView()
}
