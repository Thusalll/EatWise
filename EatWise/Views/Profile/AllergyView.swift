//
//  AllergyView.swift
//  EatWise
//
//  Created by Thusal Athauda on 21/04/2024.
//

import SwiftUI

struct AllergyView: View {
    @State private var selectedOption = ""
    @State private var isMaintainWeightSelected = true
    @State private var presentNextView = false
    
    var options: [String] = ["Fish", "Nuts", "Milk", "Cheese", "Wheat", "Shellfish"]
    
    var body: some View {
        
        ScrollView {
            VStack {
                HStack {
                    Text("EatWise")
                        .font(
                            Font.custom("Nunito", size: 74)
                                .weight(.heavy)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("TitleGreen"))
                        .frame(width: 305, height: 60, alignment: .leading)
                    Spacer()
                }
                
                HStack {
                    Text("Allergies")
                        .font(
                            Font.custom("Nunito", size: 40)
                                .weight(.bold)
                        )
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color("TextColor"))
                        .frame(width: 192, height: 61, alignment: .top)
                    
                    Spacer()
                }
                .padding(.top)
                
                
                ForEach(options, id: \.self) { option in
                    RadioButton(option: option)
                }
                
                
                .padding(.top)
                .listStyle(.plain)
                .foregroundStyle(.primaryGreen)
                
                SaveButton(text: "Save", action: {})
                    .padding()
                Spacer()
            }
            .padding(.horizontal)
        }
        
    }
}

#Preview {
    AllergyView()
}

