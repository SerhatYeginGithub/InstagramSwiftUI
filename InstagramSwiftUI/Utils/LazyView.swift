//
//  LazyView.swift
//  InstagramSwiftUI
//
//  Created by serhat on 20.10.2024.
//

import SwiftUI

struct LazyView<Content: View>: View {
    
    let build: ()-> Content
    
    init(build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
