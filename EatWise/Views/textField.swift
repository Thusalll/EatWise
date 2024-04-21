//
//  TextField.swift
//  EatWise
//
//  Created by Thusal Athauda on 21/04/2024.
//

import SwiftUI

struct textField: View {
    @State private var username: String = ""
    var placeholder: String
    //@FocusState private var emailFieldIsFocused: Bool = false
    
    var body: some View {
        TextField(
            placeholder,
            text: $username
        )
        .textInputAutocapitalization(.never)
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

#Preview {
    textField(placeholder: "custom")
}
