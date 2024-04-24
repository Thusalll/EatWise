//
//  SuDiet.swift
//  EatWise
//
//  Created by Thusal Athauda on 21/04/2024.
//

import SwiftUI

struct SuDiet: View {
    let firstName: String
    let lastName: String
    let age: String
    let email: String
    let password: String
    let weight: String
    let height: String
    let bmi: String
    let bmiMessage: String
    let heightType: String
    let weightType: String
    let goal: String
    @State private var selectedOption: String? = nil
    @State private var selectedOptions: [String]? = nil
    @State private var diet: String = ""
    @State private var isMaintainWeightSelected = true
    @State private var presentNextView = false
    
    var options: [String] = ["Balanced", "Vegetarian", "Vegan", "Carnivore"]
    
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
                    Text("Choose a Diet")
                        .font(
                            Font.custom("Nunito", size: 32)
                                .weight(.bold)
                        )
                        .foregroundColor(Color("PrimaryGreen").opacity(0.84))
                        .frame(width: 300, height: 49, alignment: .leading)
                    Spacer()
                }
                VStack {
                    ForEach(options, id: \.self) { option in
                        RadioButton(selectedOption: $selectedOption, selectedOptions: $selectedOptions, isSingleSelection: true, option: option)
                    }
                }
                .padding(.top)
                
                Spacer()
                    .frame(height: 50)
                
                // Next Button
                button(text: "Next", action: {
                    diet = selectedOption ?? ""
                    if !diet.isEmpty{
                        presentNextView.toggle()
                    }
                })
                .padding([.top], 5)
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
                SuAllergies(firstName: firstName, lastName: lastName, age: age, email: email, password: password, weight: weight, height: height, bmi: bmi, bmiMessage: bmiMessage, heightType: heightType, weightType: weightType, goal: goal, diet: diet)
        }
        }
    }
}

#Preview {
    SuDiet(firstName: "", lastName: "", age: "", email: "", password: "", weight: "", height: "", bmi: "", bmiMessage: "", heightType: "", weightType: "", goal: "")
}
