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
    
    @State private var name = "John Smith"
    @State private var age = "22"
    @State private var height = "5'11"
    @State private var weight = "85kg"
    @State private var bmi = "25 - Overweight"
    
    var body: some View {
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
                        TextField("Name", text: $name)
                    } header: {
                        Text("Name")
                            .font(
                                Font.custom("Nunito-Bold", size: 16)
                            )
                            .foregroundStyle(.primaryGreen)
                    }
                    Section {
                        TextField("Age", text: $age)
                    } header: {
                        Text("Age")
                            .font(
                                Font.custom("Nunito-Bold", size: 16)
                            )
                            .foregroundStyle(.primaryGreen)
                    }
                    Section {
                        TextField("Weught", text: $weight)
                    } header: {
                        Text("Weight")
                            .font(
                                Font.custom("Nunito-Bold", size: 16)
                            )
                            .foregroundStyle(.primaryGreen)
                    }
                    Section {
                        TextField("Weught", text: $height)
                    } header: {
                        Text("Height")
                            .font(
                                Font.custom("Nunito-Bold", size: 16)
                            )
                            .foregroundStyle(.primaryGreen)
                    }
                    Section {
                        TextField("Weught", text: $bmi)
                    } header: {
                        Text("BMI")
                            .font(
                                Font.custom("Nunito-Bold", size: 16)
                            )
                            .foregroundStyle(.primaryGreen)
                    }
                }
                 .listStyle(.plain)
                //.background(Color.secondaryGreen)
                
                
                
                //Spacer()
                
            }
            
            .padding(.horizontal)
        
        
    }
}

#Preview {
    PersonalInfoView()
}
