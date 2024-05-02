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
    @FocusState private var focusInput: Field?
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    private func isValidEmail(_ email: String) -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }

    
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
                    
                    VStack{
                        // First Name Textfield
                        textField(text: $firstName, placeholder: "First Name")
                            .padding([.bottom], 10)
                            .focused($focusInput, equals: .firstName)
                        // Last Name Textfield
                        textField(text: $lastName, placeholder: "Last Name")
                            .padding([.bottom], 10)
                            .focused($focusInput, equals: .lastName)
                        // Age Textfield
                        textField(text: $age, placeholder: "Age")
                            .keyboardType(.numberPad)
                            .padding([.bottom], 10)
                            .focused($focusInput, equals: .age)
                        // Email Textfield
                        textField(text: $email, placeholder: "Email")
                            .textInputAutocapitalization(.never)
                            .padding([.bottom], 10)
                            .focused($focusInput, equals: .email)
                        HStack{
                            if !email.isEmpty && !isValidEmail(email){
                                Text("Invalid email format")
                                    .font(.caption)
                                    .foregroundColor(.red)
                                    .multilineTextAlignment(.leading)
                            }
                            Spacer()
                        }

                        //Password Textfield
                        textField(text: $password, placeholder: "Password", isSecureField: true)
                            .padding([.bottom], 10)
                            .focused($focusInput, equals: .password)
                        HStack{
                            if !password.isEmpty && password.count < 6 {
                                    Text("Password too short")
                                        .font(.caption)
                                        .foregroundColor(.red)
                                        .multilineTextAlignment(.leading)
                                }
                            Spacer()
                        }
                    }
                    
                    Spacer()
                        .frame(height: 50)
                    
                    // Next Button
                    button(text: "Next", action: {
                        if (!firstName.isEmpty || !lastName.isEmpty || !age.isEmpty || !email.isEmpty || !password.isEmpty
                            || password.count > 5){
                            presentNextView.toggle()
                        } else {
                            print("Fill all the fields")
                        }
                    },
                           color: .primaryGreen.opacity(isValidEmail(email) && (password.count > 5 ) ? 1.0 : 0.3)
                    )
                    .disabled(firstName.isEmpty || lastName.isEmpty || age.isEmpty || !isValidEmail(email) || password.count < 5 )
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
                .toolbar{
                    ToolbarItemGroup(placement: .keyboard) {
                        Button(action: {
                            dismissKeyboard()
                        }, label: {
                            Text("Done")
                        })
                        
                        Spacer()
                        
                        Button(action: {
                            previous()
                        }, label: {
                            Image(systemName: "chevron.left")
                        }).disabled(hasReachedStart)
                        
                        Button(action: {
                            next()
                        }, label: {
                            Image(systemName: "chevron.right")
                        }).disabled(hasReachedEnd)
                    }
                }

            }
        }
    }
}

#Preview {
    SuPersonal()
}

private extension SuPersonal{
    
    var hasReachedEnd: Bool {
        focusInput == Field.allCases.last
    }
    
    var hasReachedStart: Bool {
        focusInput == Field.allCases.first
    }
    
    func dismissKeyboard() {
        focusInput = nil
    }
    
    func next() {
        guard let currentInput = focusInput, let lastIndex = Field.allCases.last?.rawValue else { return }
        
        let index = min(currentInput.rawValue + 1, lastIndex)
        focusInput = Field(rawValue: index)
    }
    
    func previous() {
        guard let currentInput = focusInput, let firstIndex = Field.allCases.first?.rawValue else { return }
        
        let index = max(currentInput.rawValue - 1, firstIndex)
        focusInput = Field(rawValue: index)
    }
}

private extension SuPersonal{
    enum Field: Int, Hashable, CaseIterable {
        case firstName
        case lastName
        case age
        case email
        case password
    }
}
