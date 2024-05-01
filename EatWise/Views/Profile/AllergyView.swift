//
//  AllergyView.swift
//  EatWise
//
//  Created by Thusal Athauda on 21/04/2024.
//

import SwiftUI

struct AllergyView: View {
    @State private var selectedOption: String?
    @State private var selectedOptions: [String] = []
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userViewModel: UserViewModel
    
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
                    RadioButton(selectedOption: $selectedOption, selectedOptions: $selectedOptions, isSingleSelection: false, option: option)
                }
                
                
                .padding(.top)
                .listStyle(.plain)
                .foregroundStyle(.primaryGreen)
                
                SaveButton(text: "Save", action: {
                    Task{
                        await userViewModel.updateUserAllergies(newAllergies: selectedOptions)
                        presentationMode.wrappedValue.dismiss()
                    }
                })
                    .padding()
                Spacer()
            }
            .padding(.horizontal)
        }
        .onAppear{
            selectedOptions = userViewModel.userModel?.allergies ?? []
        }
    }
}

#Preview {
    AllergyView()
}

