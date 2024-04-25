//
//  PersonalInfoView.swift
//  EatWise
//
//  Created by Thusal Athauda on 21/04/2024.
//

import SwiftUI

struct PersonalInfoView: View {
    @State private var selectedOption = ""
    @State private var isMaintainWeightSelected = true
    @State private var presentNextView = false
    
    @State private var name = ""
    @State private var age = ""
    @State private var height = ""
    @State private var weight = ""
    @State private var bmi = ""
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        if let user = userViewModel.userModel{
            VStack {
                HStack {
                    Text("EatWise")
                        .font(
                            Font.custom("Nunito", size: 60)
                                .weight(.heavy)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("TitleGreen"))
                        .frame(width: 305, height: 65, alignment: .leading)
                    Spacer()
                }
                
                HStack {
                    Text("Your Profile")
                        .font(
                            Font.custom("Nunito", size: 34)
                                .weight(.bold)
                        )
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color("TextColor"))
                        .frame(width: 200, height: 60, alignment: .top)
                    
                    Spacer()
                }
                .padding(.top)
                
                List{
                    Section {
                        TextField((user.firstName + " " + user.lastName), text: $name)
                            .disabled(true)
                    } header: {
                        Text("Name")
                            .font(
                                Font.custom("Nunito-Bold", size: 16)
                            )
                            .foregroundStyle(.primaryGreen)
                    }
                    Section {
                        TextField(user.age, text: $age)
                            .disabled(true)
                    } header: {
                        Text("Age")
                            .font(
                                Font.custom("Nunito-Bold", size: 16)
                            )
                            .foregroundStyle(.primaryGreen)
                    }
                    Section {
                        if let latestWeightEntry = user.latestWeightEntry {
                            TextField("\(latestWeightEntry.weight) \(user.weightType)", text: $weight)
                                .disabled(true)
                        }
                    } header: {
                        Text("Weight")
                            .font(
                                Font.custom("Nunito-Bold", size: 16)
                            )
                            .foregroundStyle(.primaryGreen)
                    }
                    Section {
                        TextField((user.height + user.heightType), text: $height)
                            .disabled(true)
                    } header: {
                        Text("Height")
                            .font(
                                Font.custom("Nunito-Bold", size: 16)
                            )
                            .foregroundStyle(.primaryGreen)
                    }
                    Section {
                        TextField((user.bmi + " - " + user.bmiMessage), text: $bmi)
                            .disabled(true)
                    } header: {
                        Text("BMI")
                            .font(
                                Font.custom("Nunito-Bold", size: 16)
                            )
                            .foregroundStyle(.primaryGreen)
                    }
                }
                .listStyle(.plain)
            }
            .padding(.horizontal)
        }
    }
}

extension UserModel {
    var latestWeightEntry: Weight? {
        return weight.max(by: { $0.day < $1.day })
    }
}

#Preview {
    PersonalInfoView().environmentObject(UserViewModel())
}
