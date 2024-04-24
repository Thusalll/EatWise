//
//  RadioButton.swift
//  EatWise
//
//  Created by Thusal Athauda on 21/04/2024.
//

import SwiftUI

struct RadioButton: View {
    @Binding var selectedOption: String?
    @Binding var selectedOptions: [String]?
    var isSingleSelection = true
    var option:String
    var body: some View {
        
        if isSingleSelection{
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
                if (selectedOption == option) {
                    // Deselect if already selected
                    selectedOption = nil
                    //print("option: \(selectedOption)")
                } else {
                    // Select if not selected
                    selectedOption = option
                } 
            }
            .frame(width: 310, height: 60)
            .background(selectedOption == option ? Color("SecondaryGreen") : .clear)
            .overlay(
                Rectangle()
                    .inset(by: 0.5)
                    .stroke(Color("PrimaryGreen"), lineWidth: 2)
            )
            .padding(.top)
        } else {
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
                if var selectedOptions = selectedOptions {
                    if selectedOptions.contains(option) {
                        // Deselect if already selected
                        selectedOptions.removeAll { $0 == option }
                    } else {
                        // Select if not selected
                        selectedOptions.append(option)
                    }
                    self.selectedOptions = selectedOptions.isEmpty ? nil : selectedOptions
                } else {
                    // If no options selected yet, create a new array with the selected option
                    selectedOptions = [option]
                }
            }
            .frame(width: 310, height: 60)
            .background(selectedOption == option ? Color("SecondaryGreen") : .clear)
            .overlay(
                Rectangle()
                    .inset(by: 0.5)
                    .stroke(Color("PrimaryGreen"), lineWidth: 2)
            )
            .padding(.top)
        }
        
    }
}

#Preview {
    RadioButton(selectedOption: .constant(nil), selectedOptions: .constant(nil), option: "Gain Weight")
    
}
