//
//  GoalView.swift
//  EatWise
//
//  Created by Thusal Athauda on 21/04/2024.
//

import SwiftUI

struct GoalView: View {
    @State private var selectedOption: String?
    @State private var selectedOptions: [String] = []
    @State private var isMaintainWeightSelected = true
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var selectedWeightType = 1
    @State private var goalWeight: String = ""
    
    var options: [String] = ["Loose Weight", "Maintain Weight", "Gain Weight"]
    
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
                    
                    HStack {
                        textField(text: $goalWeight, placeholder: "Weight")
                            .keyboardType(.decimalPad)
                            .padding(.trailing)
                        Picker("Select Height", selection: $selectedWeightType) {
                            Text("Kg").tag(1)
                            Text("lbs").tag(2)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    .padding()
                    
                    Spacer()
                    
                    SaveButton(text: "Save", action: {
                        Task{
                            await userViewModel.updateUserGoal(newGoal: selectedOption ?? "selectedOption", goalWeight: goalWeight)
                            
                                _ = userViewModel.createMealPlan()
                                userViewModel.saveDailyMealPlan(date: Date(), mealPlan: userViewModel.mealPlan)
                            
                                _ = userViewModel.generateWeeklyMealPlan()
                                userViewModel.saveWeeklyMealPlan(weeklyMealPlan: userViewModel.weeklyMealPlan)
                            
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
                    goalWeight = userViewModel.userModel?.goalWeight ?? ""
            }
        }
        
        
    }
}

#Preview {
    GoalView()
}

