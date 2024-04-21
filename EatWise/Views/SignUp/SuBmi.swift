//
//  SuBmi.swift
//  EatWise
//
//  Created by Thusal Athauda on 21/04/2024.
//

import SwiftUI

struct SuBmi: View {
    @State private var presentNextView = false
    var body: some View {
        VStack{
            // Eatwise Title
            Title()
                .padding([.bottom], 45)
            
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
                textField(placeholder: "Height")
                    .keyboardType(.numberPad)
                    .padding(.trailing)
                Picker("Select Height", selection: .constant(2)) {
                    Text("Kg").tag(1)
                    Text("lbs").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
            }

            HStack {
                textField(placeholder: "Weight")
                    .keyboardType(.decimalPad)
                    .padding(.trailing)
                Picker("Select Height", selection: .constant(2)) {
                        Text("Cm").tag(1)
                        Text("In").tag(2)
                    }
                    .pickerStyle(SegmentedPickerStyle())
            }
            .padding([.bottom], 90)
            
            VStack{
                Text("BMI: 25")
                  .font(
                    Font.custom("Nunito-ExtraBold", size: 48)
                  )
                  .foregroundColor(Color("TextColor"))
                  .frame(width: 175, height: 63, alignment: .topLeading)
                Text("You Are Overweight")
                  .font(
                    Font.custom("Nunito-Bold", size: 36)
                  )
                  .foregroundColor(Color("TextColor"))
                  .frame(width: 340, height: 49, alignment: .topLeading)
            }
            
            Spacer()
            
            // Next Button
            button(text: "Next", action: {
                presentNextView.toggle()
            })
            .padding([.top], 90)
            .padding(.bottom)
            
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
        .padding([.top, .horizontal], 40)
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $presentNextView){
           SuGoal()
        }
    }
}

#Preview {
    SuBmi()
}
