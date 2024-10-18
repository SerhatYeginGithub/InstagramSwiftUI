//
//  PostGridView.swift
//  InstagramSwiftUI
//
//  Created by serhat on 14.10.2024.
//

import SwiftUI
import Kingfisher

struct PostGridView: View {
    
    private let items = [GridItem(), GridItem(), GridItem()]
    private let width = UIScreen.main.bounds.width / 3
    let configType: PostGridConfig
    @ObservedObject private var vm: PostGridViewModel
    
    init(configType: PostGridConfig) {
        self.configType = configType
        vm = PostGridViewModel(config: configType)
    }
    
    var body: some View {
        LazyVGrid(columns: items, spacing: 2, content: {
            ForEach(vm.posts) { post in
                NavigationLink (destination: FeedView()){
                    KFImage(URL(string: post.imageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: width)
                        .clipped()
                }
            }
            
        })
    }
    
}

