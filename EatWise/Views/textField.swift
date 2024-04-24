//
//  TextField.swift
//  EatWise
//
//  Created by Thusal Athauda on 21/04/2024.
//

import SwiftUI

struct textField: View {
    @Binding var text: String
    let placeholder: String
    var isSecureField = false
    
    var body: some View {
        
        if isSecureField{
            SecureField(
                placeholder,
                text: $text
            )
            .font(
                Font.custom("Nunito", size: 20)
            )
            .disableAutocorrection(true)
            .padding()
            .overlay(
                GeometryReader { geometry in
                    Rectangle()
                        .stroke(Color("PrimaryGreen"), lineWidth: 2)
                        .offset(x: 0, y: geometry.size.height - 1)
                        .frame(width: geometry.size.width, height: 1)
                }
            )
        } else {
            TextField(
                placeholder,
                text: $text
            )
            
            .font(
                Font.custom("Nunito", size: 20)
            )
            .disableAutocorrection(true)
            .padding()
            .overlay(
                GeometryReader { geometry in
                    Rectangle()
                        .stroke(Color("PrimaryGreen"), lineWidth: 2)
                        .offset(x: 0, y: geometry.size.height - 1) // Adjust offset for desired padding
                        .frame(width: geometry.size.width, height: 1)
                }
            )
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        textField(text: .constant(""), placeholder: "custom")
    }
}
