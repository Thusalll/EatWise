//
//  RadioButton.swift
//  EatWise
//
//  Created by Thusal Athauda on 21/04/2024.
//

import SwiftUI

struct RadioButton: View {
    @Binding var selectedOption: String? // For single selection
    @Binding var selectedOptions: [String] // For multiple selection
    var isSingleSelection: Bool = true
    var option: String

    var body: some View {
        HStack {
            Text(option)
                .padding()
                .font(
                    Font.custom("Nunito", size: 22)
                        .weight(.bold)
                )
            Spacer()
            Image(systemName: isSelected() ? "circle.fill" : "circle")
                .foregroundColor(Color("PrimaryGreen"))
                .padding()
        }
        .onTapGesture {
            if isSingleSelection {
                selectedOption = (selectedOption == option) ? nil : option
            } else {
                if selectedOptions.contains(option) {
                    selectedOptions.removeAll(where: { $0 == option })
                } else {
                    selectedOptions.append(option)
                }
            }
        }
        .frame(width: 310, height: 60)
        .background(isSelected() ? Color("SecondaryGreen") : .clear)
        .overlay(
            Rectangle()
                .inset(by: 0.5)
                .stroke(Color("PrimaryGreen"), lineWidth: 2)
        )
        .padding(.top)
    }

    // function to check the selection status
    private func isSelected() -> Bool {
        if isSingleSelection {
            return selectedOption == option
        } else {
            return selectedOptions.contains(option)
        }
    }
}


