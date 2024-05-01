//
//  SuGoal.swift
//  EatWise
//
//  Created by Thusal Athauda on 21/04/2024.
//

import SwiftUI

struct SuGoal: View {
    let firstName: String
    let lastName: String
    let age: String
    let email: String
    let password: String
    let weight: String
    let height: String
    let bmi: String
    let bmiMessage: String
    let calories: String
    let heightType: String
    let weightType: String
    @State private var selectedOption: String? = nil
    @State private var selectedOptions: [String] = []
    @State private var goal: String = ""
    @State private var isMaintainWeightSelected = true
    @State private var presentNextView = false
    @State private var selectedWeightType = 1
    @State private var goalWeight: String = ""
    
    var options: [String] = ["Lose Weight", "Maintain Weight", "Gain Weight"]
    
    var body: some View {
        ScrollView {
            VStack {
                // Eatwise Title
                Title()
                    .padding([.bottom], 35)
                
                // Signup Title
                HStack {
                    Text("Sign Up")
                        .font(
                            Font.custom("Nunito-Bold", size: 50)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("TextColor"))
                        .frame(width: 195, height: 60)
                        .padding([.bottom], 30)
                    Spacer()
                }
                
                // Goal heading
                HStack {
                    Text("What Is Your Goal?")
                        .font(
                            Font.custom("Nunito", size: 32)
                                .weight(.bold)
                        )
                        .foregroundColor(Color("PrimaryGreen").opacity(0.84))
                        .frame(width: 300, height: 49)
                    Spacer()
                }
                VStack {
                    ForEach(options, id: \.self) { option in
                        RadioButton(selectedOption: $selectedOption, selectedOptions: $selectedOptions, isSingleSelection: true, option: option)
                    }
                }
                .padding([.top, .bottom])
                
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
                
                
                // Next Button
                button(text: "Next", action: {
                    if selectedWeightType == 1 {
                        goalWeight = goalWeight + " kg"
                    } else {
                        goalWeight = goalWeight + " lbs"
                    }
                    
                    goal = selectedOption ?? ""
                    if !goal.isEmpty && !goalWeight.isEmpty{
                        print(goal)
                        presentNextView.toggle()
                    }
                })
                .padding([.top], 40)
                .padding([.bottom], 5)
                
                //Spacer()
                
                // Login label
                HStack {
                    Text("Already have an account?")
                        .foregroundStyle(Color("TextColor"))
                        .font(Font.custom("Nunito", size: 14))
                    
                    NavigationLink(destination: LoginView()) {
                        Text("Log In")
                            .foregroundStyle(Color("TextColor"))
                            .font(Font.custom("Nunito-Bold", size: 14))
                    }
                }
            }
            //.padding(.bottom)
            .padding([.horizontal], 40)
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $presentNextView){
                SuDiet(firstName: firstName, lastName: lastName, age: age, email: email, password: password, weight: weight, height: height, bmi: bmi, bmiMessage: bmiMessage, calories: calories, heightType: heightType, weightType: weightType, goal: goal, goalWeight: goalWeight)
            }
        }
    }
}

#Preview {
    SuGoal(firstName: "", lastName: "", age: "", email: "", password: "", weight: "", height: "", bmi: "", bmiMessage: "", calories: "", heightType: "", weightType: "")
}
