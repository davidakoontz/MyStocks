//
//  TextField+ViewModifier.swift
//  MyStocks
//
//  Created by David on 4/14/22.
//

import SwiftUI

struct TextFieldClearButton: ViewModifier {
    @Binding var text: String
    
    func body(content: Content) -> some View {
        HStack {
            content
            
            if !text.isEmpty {
                Button(
                    action: { self.text = "" },
                    label: {
                        Image(systemName: "delete.left")
                            .foregroundColor(Color(UIColor.opaqueSeparator))
                    }
                )
            }
        }
    }
}

//  Usage Example:
//
//TextField("Type in your Text here...", text: $exampleText)
//    .modifier(TextFieldClearButton(text: $exampleText))
//    .multilineTextAlignment(.leading)
