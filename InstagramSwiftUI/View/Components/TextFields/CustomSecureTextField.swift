//
//  CustomSecureTextField.swift
//  InstagramSwiftUI
//
//  Created by serhat on 15.10.2024.
//

import SwiftUI

struct CustomSecureTextField: View {
    let placeholder: String
    let icon: String
    @Binding var tf: String
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(Color(.init(white: 1, alpha: 0.8)))
            SecureField("", text: $tf, prompt: promptText )
               
            
        }
        .padding()
        .background(Color(.init(white: 1, alpha: 0.15)))
        .cornerRadius(12)
 
    }
}


private extension CustomSecureTextField {
    @ViewBuilder
    var promptText: Text {
        Text(placeholder)
            .foregroundColor(Color(.init(white: 1, alpha: 0.8)))
    }
}

#Preview {
    CustomSecureTextField(placeholder: "Password", icon: "Lock", tf: .constant(""))
}
