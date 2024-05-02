//
//  SuAllergies.swift
//  EatWise
//
//  Created by Thusal Athauda on 21/04/2024.
//

import SwiftUI

struct SuAllergies: View {
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
    let goal: String
    let goalWeight: String
    let diet: String
    
    @State private var selectedOption: String? = nil  // For single selection
    @State private var selectedOptions: [String] = []
    @State private var isMaintainWeightSelected = true
    @State private var presentNextView = false
    @EnvironmentObject var userViewModel: UserViewModel
    
    var options: [String] = ["Fish", "Nuts", "Milk", "Cheese", "Wheat", "Shellfish"]
    
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
                    Text("Choose Any Allergies")
                        .font(
                            Font.custom("Nunito", size: 28)
                                .weight(.bold)
                        )
                        .foregroundColor(Color("PrimaryGreen").opacity(0.84))
                        .frame(width: 300, height: 49, alignment: .leading)
                    Spacer()
                }
                VStack {
                    ForEach(options, id: \.self) { option in
                        RadioButton(selectedOption: $selectedOption, selectedOptions: $selectedOptions, isSingleSelection: false, option: option)
                    }
                }
                .padding(.top)
                
                Spacer()
                
                // Next Button
                button(text: "Sign Up", action: {
                    Task{
                        try await userViewModel.createUser(withEmail: email,
                                                           password: password,
                                                           firstName: firstName,
                                                           lastname: lastName,
                                                           age: age,
                                                           height: height,
                                                           weight: [Weight(id: UUID().uuidString, weight: weight, day: Date())],
                                                           bmi: bmi,
                                                           bmiMessage: bmiMessage, 
                                                           calories: calories,
                                                           goal: goal,
                                                           goalWeight: goalWeight,
                                                           diet: diet,
                                                           allergies: selectedOptions,
                                                           weightType: weightType,
                                                           heightType: heightType
                        )
                    }
                }, color: .primaryGreen)
                .padding([.top], 25)
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
            .padding([.horizontal], 40)
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    SuAllergies(firstName: "", lastName: "", age: "", email: "", password: "", weight: "", height: "", bmi: "", bmiMessage: "", calories: "", heightType: "", weightType: "", goal: "", goalWeight: "", diet: "")
}
