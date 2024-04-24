//
//  SuPersonal.swift
//  EatWise
//
//  Created by Thusal Athauda on 21/04/2024.
//

import SwiftUI

struct SuPersonal: View {
    @State private var password: String = ""
    @State private var age: String = ""
    @State private var email: String = ""
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var presentNextView = false
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        NavigationStack {
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
                            .padding([.bottom], 35)
                        Spacer()
                    }
                    
                    // First Name Textfield
                    textField(text: $firstName, placeholder: "First Name")
                        .padding([.bottom], 20)
                    // Last Name Textfield
                    textField(text: $lastName, placeholder: "Last Name")
                        .padding([.bottom], 20)
                    // Age Textfield
                    textField(text: $age, placeholder: "Age")
                        .padding([.bottom], 20)
                    // Email Textfield
                    textField(text: $email, placeholder: "Email")
                        .textInputAutocapitalization(.never)
                        .padding([.bottom], 20)
                    //Password Textfield
                    textField(text: $password, placeholder: "Password", isSecureField: true)
                        .padding([.bottom], 20)
                    Spacer()
                    
                    // Next Button
                    button(text: "Next", action: {
                        if (!firstName.isEmpty || !lastName.isEmpty || !age.isEmpty || !email.isEmpty || !password.isEmpty){
                            presentNextView.toggle()
                        } else {
                            print("Fill all the fields")
                        }
                    })
                    .padding([.top], 30)
                    .padding([.bottom], 5)
                    
                    //Spacer()
                    
                    // Login label
                    Button(action: {
                        dismiss()
                    }, label: {
                        HStack {
                            Text("Already have an account?")
                                .foregroundStyle(Color("TextColor"))
                                .font(Font.custom("Nunito", size: 14))
                            Text("Log In")
                                .foregroundStyle(Color("TextColor"))
                                .font(Font.custom("Nunito-Bold", size: 14))
                        }
                        .padding(.bottom)
                    })
                    
                }
                .padding(.bottom)
                .padding([ .horizontal], 40)
                .navigationDestination(isPresented: $presentNextView){
                    SuBmi(firstName: firstName, lastName: lastName, age: age, email: email, password: password)
                }
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}

#Preview {
    SuPersonal()
}
