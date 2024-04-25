//
//  GoalView.swift
//  EatWise
//
//  Created by Thusal Athauda on 21/04/2024.
//

import SwiftUI

struct GoalView: View {
    @State private var selectedOption: String?
    @State private var selectedOptions: [String]? = nil
    @State private var isMaintainWeightSelected = true
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userViewModel: UserViewModel
    
    var options: [String] = ["Loose Weight", "Maintain Weight", "Gain Weight"]
    
    var body: some View {
            VStack {
                HStack {
                    Text("EatWise")
                        .font(
                            Font.custom("Nunito", size: 74)
                                .weight(.heavy)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("TitleGreen"))
                        .frame(width: 305, height: 87, alignment: .leading)
                    Spacer()
                }
                
                HStack {
                    Text("Goal")
                        .font(
                            Font.custom("Nunito", size: 40)
                                .weight(.bold)
                        )
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color("TextColor"))
                        .frame(width: 90, height: 60, alignment: .top)
                    
                    Spacer()
                }
                .padding(.top)
                
                ForEach(options, id: \.self) { option in
                    RadioButton(selectedOption: $selectedOption, selectedOptions: $selectedOptions, isSingleSelection: true, option: option)
                }
                .padding(.top)
                .listStyle(.plain)
                .foregroundStyle(.primaryGreen)
                
                
                Spacer()
                
                SaveButton(text: "Save", action: {
                    Task{
                        await userViewModel.updateUserGoal(newGoal: selectedOption ?? "selectedOption")
                        // Dismiss the GoalView and go back to the previous view (ProfileView)
                        presentationMode.wrappedValue.dismiss()
                    }
                })
                    .padding()
                
            }
            .padding(.horizontal)
            .onAppear {
                // Initialize selectedOption with the value from ViewModel
                selectedOption = userViewModel.userModel?.goal
                print(selectedOption)
            }
        
        
    }
}

#Preview {
    GoalView()
}

