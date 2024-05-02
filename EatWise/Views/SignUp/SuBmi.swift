//
//  SuBmi.swift
//  EatWise
//
//  Created by Thusal Athauda on 21/04/2024.
//

import SwiftUI

struct SuBmi: View {
    let firstName: String
    let lastName: String
    let age: String
    let email: String
    let password: String
    @State private var presentNextView = false
    @State private var selectedWeightType = 1
    @State private var selectedHeightType = 1
    @State private var weight: String = ""
    @State private var height: String = ""
    @State private var bmiValue: String = ""
    @State private var bmiMessage: String = ""
    @State private var weightType: String = ""
    @State private var heightType: String = ""
    @State private var disabled = false
    
    func calculateBMI() {
        guard let weightValue = Double(weight) else {
            // Invalid weight input, return
            return
        }
        
        let heightValue: Double
        if selectedHeightType == 1 { // Height is in cm
            guard let heightCm = Double(height) else {
                // Invalid height input, return
                return
            }
            heightValue = heightCm / 100 // Convert cm to m
        } else { // Height is in feet and inches
            // Split the height string by "."
            let components = height.components(separatedBy: ".")
            guard components.count == 2,
                  let feet = Double(components[0]),
                  let inches = Double(components[1]) else {
                // Invalid height input, return
                return
            }
            // Convert feet and inches to cm
            heightValue = (feet * 12 + inches) * 2.54 / 100 // Convert inches to cm, then to m
        }
        
        let weightInKg = selectedWeightType == 1 ? weightValue : weightValue * 0.453592 // Convert lbs to kg
        
        let bmi = weightInKg / (heightValue * heightValue)
        bmiValue = String(format: "%.1f", bmi)
        
        
        // Determine the BMI message
        switch bmi {
        case ..<18.5:
            bmiMessage = "You Are Underweight"
        case 18.5..<24.9:
            bmiMessage = "You Are Normal weight"
        case 24.9..<29.9:
            bmiMessage = "You Are Overweight"
        default:
            bmiMessage = "You Are Obese"
        }
        
    }
    
    var body: some View {
        ScrollView {
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
                        .padding([.bottom], 45)
                    Spacer()
                }
                HStack {
                    textField(text: $height, placeholder: "Height")
                        .keyboardType(.decimalPad)
                        .padding(.trailing)
                    Picker("Select Height", selection: $selectedHeightType) {
                        Text("Cm").tag(1)
                        Text("Ft").tag(2)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                HStack {
                    textField(text: $weight, placeholder: "Weight")
                        .keyboardType(.decimalPad)
                        .padding(.trailing)
                    Picker("Select Height", selection: $selectedWeightType) {
                        Text("Kg").tag(1)
                        Text("lbs").tag(2)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding([.bottom], 20)
                
                Button(action: {
                    calculateBMI()
                    disabled.toggle()
                    if (selectedHeightType == 1) {
                        heightType = "Cm"
                    } else {
                        heightType = "Ft"
                    }
                    if (selectedWeightType == 1) {
                        weightType = "Kg"
                    } else {
                        weightType = "lbs"
                    }
                }, label: {
                    Text("Calculate BMI")
                        .padding()
                        .foregroundStyle(.white)
                        .background(.primaryGreen.opacity(weight.isEmpty || height.isEmpty ? 0.3 : 1.0))
                        .cornerRadius(10)
                        .padding([.bottom], 40)
                })
                .disabled(weight.isEmpty || height.isEmpty)
                
                VStack (alignment: .center){
                    if (!bmiValue.isEmpty){
                        Text("BMI: \(bmiValue)")
                            .font(
                                Font.custom("Nunito-ExtraBold", size: 40)
                            )
                            .foregroundColor(Color("TextColor"))
                            .frame(height: 63, alignment: .center)
                        
                    } else {
                        Text("")
                            .frame(height: 63, alignment: .center)
                    }
                    Text(bmiMessage)
                        .font(
                            Font.custom("Nunito-Bold", size: 24)
                        )
                        .foregroundColor(Color("TextColor"))
                        .frame(height: 49, alignment: .center)
                }
                
                Spacer()
                
                // Next Button
                button(text: "Next", action: {
                    if (weight.isEmpty || height.isEmpty || weightType.isEmpty || heightType.isEmpty){
                        print("Fill all the fields")
                    } else {
                        presentNextView.toggle()
                    }
                    
                }, 
                       color: .primaryGreen.opacity(disabled ? 1.0 : 0.3)
                )
                .disabled(bmiValue.isEmpty)
                .padding([.top], 70)
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
                SuCalorie(firstName: firstName, lastName: lastName, age: age, email: email, password: password, weight: weight, height: height, bmi: bmiValue, bmiMessage: bmiMessage, heightType: heightType, weightType: weightType)
            }
        }
    }
}

#Preview {
    SuBmi(firstName: "", lastName: "", age: "", email: "", password: "")
}
