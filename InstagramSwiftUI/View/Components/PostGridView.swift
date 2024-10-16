//
//  PostGridView.swift
//  InstagramSwiftUI
//
//  Created by serhat on 14.10.2024.
//

import SwiftUI

struct PostGridView: View {
    private let items = [GridItem(), GridItem(), GridItem()]
    private let width = UIScreen.main.bounds.width / 3
    var body: some View {
        LazyVGrid(columns: items, spacing: 2, content: {
            ForEach(0...19, id: \.self) { _ in
                NavigationLink (destination: FeedView()){
                    Image("panda")
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: width)
                    .clipped()
                }
            }
            
        })
    }
}

#Preview {
    PostGridView()
}
