//
//  LoginView.swift
//  EatWise
//
//  Created by Thusal Athauda on 21/04/2024.
//

import SwiftUI

struct LoginView: View {
    @State private var password: String = ""
    var body: some View {
        NavigationStack {
            VStack {
                // Eatwise Title
                Title()
                    .padding([.bottom], 70)
                
                // Login Title
                HStack {
                    Text("Log in")
                        .font(
                            Font.custom("Nunito-Bold", size: 50)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("TextColor"))
                        .frame(width: 145, height: 60)
                        .padding([.bottom], 80)
                    Spacer()
                }
                
                // Email Textfield
                textField(placeholder: "Email")
                    .padding([.bottom], 50)
                
                // Password Textfield
                SecureField(
                    "Password",
                    text: $password
                )
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .padding()
                .overlay(
                    GeometryReader { geometry in
                        Rectangle()
                            .stroke(Color("PrimaryGreen"), lineWidth: 2)
                            .offset(x: 0, y: geometry.size.height - 1)
                            .frame(width: geometry.size.width, height: 1)
                    }
                )
                .padding([.bottom], 80)
                
                // Login Button
                button(text: "Login", action: {})
                
                Spacer()
                
                // sign up label
                HStack {
                    Text("Don't have an account?")
                        .foregroundStyle(Color("TextColor"))
                        .font(Font.custom("Nunito", size: 14))
                    
                    NavigationLink(destination: SuPersonal()) {
                        Text("Sign Up")
                            .foregroundStyle(Color("TextColor"))
                            .font(Font.custom("Nunito-Bold", size: 14))
                    }
                }
            }
            .padding([.top, .horizontal], 40)
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    LoginView()
}
