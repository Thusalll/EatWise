//
//  SuCalorie.swift
//  EatWise
//
//  Created by Thusal Athauda on 27/04/2024.
//

import SwiftUI

struct SuCalorie: View {
    
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
    @State private var presentNextView = false
    @State private var totalCalories = ""
    @State private var selectedGender = 0
    @State private var selectedActivity = 1

    private func calculateCalories() {
        guard let age = Double(age),
              let height = Double(height),
              let weight = Double(weight) else {
            // Handle invalid input
            return
        }

        var bmr: Double

        if selectedGender == 1 {
            bmr = 10 * weight + 6.25 * height - 5 * age + 5
        } else {
            bmr = 10 * weight + 6.25 * height - 5 * age - 161
        }

        // Adjust for activity level
        let activityFactor: Double
           switch selectedActivity {
           case 1:
               activityFactor = 1.2 // Sedentary
           case 2:
               activityFactor = 1.375 // Lightly Active
           case 3:
               activityFactor = 1.55 // Moderate
           case 4:
               activityFactor = 1.725 // Very Active
           case 5:
               activityFactor = 1.9 // Extra Active
           default:
               activityFactor = 1.0 // Default to Sedentary if selectedActivity is invalid
           }
        
        let calories = bmr * activityFactor
        totalCalories = String(format: "%.0f", calories)

        // Output the result
        print("Your estimated daily calorie needs: \(totalCalories) calories")
    }


    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
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
                            .padding([.bottom], 35)
                        Spacer()
                    }
                    
                    HStack {
                        Text("Gender")
                            .font(
                                Font.custom("Nunito-Bold", size: 20)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color("TextColor"))
                            .padding(.trailing)
                        Picker("Select Gender", selection: $selectedGender) {
                            Text("Male").tag(1)
                            Text("Female").tag(2)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    .padding(.bottom)
                    
                    HStack {
                        Text("Activity Level")
                            .font(
                                Font.custom("Nunito-Bold", size: 20)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color("TextColor"))
                            .padding(.trailing)
                        Picker("Activity Level", selection: $selectedActivity) {
                                Text("Sedentary").tag(1)
                                Text("Lightly Active").tag(2)
                                Text("Moderate").tag(3)
                                Text("Very Active").tag(4)
                                Text("Extra Active").tag(5)
                        }
                        .tint(Color.primaryGreen)
                        .pickerStyle(DefaultPickerStyle())
                        Spacer()
                    }
                    .padding(.bottom, 20)
                    
                    Button(action: {
                        calculateCalories()
                    }, label: {
                        Text("Calculate Calories")
                            .padding()
                            .foregroundStyle(.white)
                            .background(.primaryGreen)
                            .cornerRadius(10)
                            .padding([.bottom], 40)
                    })
                    .disabled(selectedGender == 0)
                    
                    VStack (alignment: .center){
                        if (!totalCalories.isEmpty){
                            Text("Calories: \(totalCalories)")
                                .font(
                                    Font.custom("Nunito-ExtraBold", size: 30)
                                )
                                .foregroundColor(Color("TextColor"))
                                .frame(height: 63, alignment: .center)
                            
                        } else {
                            Text("")
                                .frame(height: 63, alignment: .center)
                        }
                    }
                    
                    button(text: "Next", action: {
                        if !totalCalories.isEmpty{
                            presentNextView.toggle()
                        } else {
                            return
                        }
                    })
                    .padding([.top], 150)
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
                .padding(.bottom)
                .padding([ .horizontal], 40)
                .navigationBarBackButtonHidden(true)
                .navigationDestination(isPresented: $presentNextView){
                    SuGoal(firstName: firstName, lastName: lastName, age: age, email: email, password: password, weight: weight, height: height, bmi: bmi, bmiMessage: bmiMessage, calories: totalCalories, heightType: heightType, weightType: weightType)
                }
            }
        }
    }
}

#Preview {
    SuCalorie(firstName: "", lastName: "", age: "", email: "", password: "", weight: "", height: "", bmi: "", bmiMessage: "", heightType: "", weightType: "")
}
