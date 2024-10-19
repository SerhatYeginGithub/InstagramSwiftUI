//
//  UIApplication+Ext.swift
//  InstagramSwiftUI
//
//  Created by serhat on 19.10.2024.
//

import SwiftUI

extension UIApplication {
    
    func endEditing() {
            sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
}
