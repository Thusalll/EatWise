//
//  SuPersonal.swift
//  EatWise
//
//  Created by Thusal Athauda on 21/04/2024.
//

import SwiftUI

struct SuPersonal: View {
    @State private var password: String = ""
    @State private var presentNextView = false
    
    var body: some View {
        NavigationStack {
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
                        .padding([.bottom], 35)
                    Spacer()
                }
                
                // First Name Textfield
                textField(placeholder: "First Name")
                    .padding([.bottom], 20)
                // Last Name Textfield
                textField(placeholder: "Last Name")
                    .padding([.bottom], 20)
                // Age Textfield
                textField(placeholder: "Age")
                    .padding([.bottom], 20)
                // Email Textfield
                textField(placeholder: "Email")
                    .padding([.bottom], 20)
                // Password Textfield
                SecureField(
                    "Password",
                    text: $password
                )
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .padding()
                .font(
                    Font.custom("Nunito-Bold", size: 20)
                )
                .overlay(
                    GeometryReader { geometry in
                        Rectangle()
                            .stroke(Color("PrimaryGreen"), lineWidth: 2)
                            .offset(x: 0, y: geometry.size.height - 1)
                            .frame(width: geometry.size.width, height: 1)
                    }
                )
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
                    
                    NavigationLink(destination: LoginView()) {
                        Text("Log In")
                            .foregroundStyle(Color("TextColor"))
                            .font(Font.custom("Nunito-Bold", size: 14))
                    }
                }
            }
            .padding(.bottom)
            .padding([.top, .horizontal], 40)
            .navigationDestination(isPresented: $presentNextView){
                SuBmi()
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    SuPersonal()
}
