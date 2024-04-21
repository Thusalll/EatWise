//
//  RadioButton.swift
//  EatWise
//
//  Created by Thusal Athauda on 21/04/2024.
//

import SwiftUI

struct RadioButton: View {
    @State private var selectedOption = ""
    var option:String
    var body: some View {
        HStack {
            Text(option)
                .padding()
                .font(
                    Font.custom("Nunito", size: 22)
                        .weight(.bold)
                )
            Spacer()
            Image(systemName: selectedOption == option ? "circle.fill" : "circle")
                .foregroundColor(Color("PrimaryGreen"))
                .padding()
        }
        .onTapGesture {
            selectedOption = option
        }
        .frame(width: 310, height: 60)
                .background(selectedOption == option ? Color("SecondaryGreen") : Color("TextFieldBG"))
                .overlay(
                    Rectangle()
                        .inset(by: 0.5)
                        .stroke(Color("PrimaryGreen"), lineWidth: 2)
                )
                .padding(.top)
    }
}

#Preview {
    RadioButton(option: "Gain Weight")

}
