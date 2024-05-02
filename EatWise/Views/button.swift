//
//  Button.swift
//  EatWise
//
//  Created by Thusal Athauda on 21/04/2024.
//

import SwiftUI

struct button: View {
    var text: String
    var action: () -> Void
    var color: Color
    
    var body: some View {
        HStack {
            Button(action:action) {
                Text(text)
                    .frame(maxWidth: .infinity, maxHeight: 25)
                    .font(
                        Font.custom("Nunito-Bold", size: 30)
                    )
                    .foregroundColor(.white)
                    .padding()
                    .background(color)
                    .cornerRadius(15)
            }
        }
    }
}


#Preview {
    button(text: "text", action: {}, color: .primaryGreen)
}
