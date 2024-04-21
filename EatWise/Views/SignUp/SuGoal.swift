//
//  SuGoal.swift
//  EatWise
//
//  Created by Thusal Athauda on 21/04/2024.
//

import SwiftUI

struct SuGoal: View {
    @State private var selectedOption = ""
    @State private var isMaintainWeightSelected = true
    @State private var presentNextView = false
    
    var options: [String] = ["Lose Weight", "Maintain Weight", "Gain Weight"]
    
    var body: some View {
        VStack {
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
                    RadioButton(option: option)
                }
            }
            .padding(.top)
            
            Spacer()
            
            // Next Button
            button(text: "Next", action: {
                presentNextView.toggle()
            })
            .padding([.top], 40)
            .padding(.bottom)
            
            //Spacer()
            
            // Login label
            HStack {
                Text("Already have an account?")
                    .foregroundStyle(Color("TextColor"))
                    .font(Font.custom("Nunito", size: 14))
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Log In")
                        .foregroundStyle(Color("TextColor"))
                        .font(Font.custom("Nunito-Bold", size: 14))
                })
            }
        }
        //.padding(.bottom)
        .padding([.top, .horizontal], 40)
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $presentNextView){
            SuDiet()
        }
    }
}

#Preview {
    SuGoal()
}
