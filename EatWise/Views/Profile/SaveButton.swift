//
//  SaveButton.swift
//  EatWise
//
//  Created by Thusal Athauda on 21/04/2024.
//

import SwiftUI

struct SaveButton: View {
    var text: String
    var action: () -> Void
    
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
                    .background(Color("PrimaryGreen"))
                    .cornerRadius(15)
            }
        }
    }
}

#Preview {
    SaveButton(text: "Save", action: {})
}
