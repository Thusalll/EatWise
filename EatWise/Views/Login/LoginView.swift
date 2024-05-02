//
//  LoginView.swift
//  EatWise
//
//  Created by Thusal Athauda on 21/04/2024.
//

import SwiftUI

struct LoginView: View {
    @State private var password: String = ""
    @State private var email: String = ""
    @EnvironmentObject var userViewModel: UserViewModel
    var body: some View {
        NavigationStack {
            ScrollView {
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
                    textField(text: $email, placeholder: "Email")
                        .textInputAutocapitalization(.never)
                        .padding([.bottom], 10)
                    
                    // Password Textfield
                    textField(text: $password, placeholder: "Password", isSecureField: true)
                        .padding([.bottom], 100)
                    
                    // Login Button
                    button(text: "Login", action: {
                        Task{
                            try await userViewModel.logIn(withEmail: email, password: password)
                        }
                    },
                           color: .primaryGreen
                    )
                    
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
}

#Preview {
    LoginView()
}
