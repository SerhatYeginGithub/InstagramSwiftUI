//
//  CommentsView.swift
//  InstagramSwiftUI
//
//  Created by serhat on 19.10.2024.
//

import SwiftUI

struct CommentsView: View {
    
    @ObservedObject private var vm: CommentViewModel
    private let post: Post
    @State private var isHidden = true
    @Environment(\.dismiss) private var dismiss
    
    init(post: Post) {
        self.post = post
        vm = CommentViewModel(post: post)
    }
    
    var body: some View {
        VStack {
            // comment list
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(vm.comments) { comment in
                        CommentCell(comment: comment)
                            .padding()
                    }
                }
            }
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
            // Input view
            inputView
        }
        .padding(.vertical)
        .navigationBarItems(leading: dismissBarButtonItem)
        .toolbar(isHidden ? .hidden : .automatic , for: .tabBar)
        .navigationBarBackButtonHidden(true)
       
    }
}


private extension CommentsView {
    var inputView: some View {
        VStack {
            // Divider
            Rectangle()
                .fill(Color(.separator))
                .frame(height: 0.75)
                .padding(.bottom, 8)
            HStack {
                TextField("Message", text: $vm.commentText, axis: .vertical)
                    
                Button("Send") {
                    vm.uploadComment(commentText: vm.commentText)
                }
                    .fontWeight(.semibold)
                
            }
            .padding(.bottom, 10)
            .padding(.horizontal)
           
     
       
        }
    }
    
    var dismissBarButtonItem: some View {
        Button {
            dismiss()
            isHidden = false
        } label: {
            Image(systemName: "chevron.left")
        }

    }
    
 
}
