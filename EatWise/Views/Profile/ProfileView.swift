//
//  ProfileView.swift
//  EatWise
//
//  Created by Thusal Athauda on 21/04/2024.
//

import SwiftUI
import Charts

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack {
                Title()
                
                WeightGraph()
                
                List {
                    NavigationLink(destination: AllergyView()) {
                        Text("Allergies")
                            .font(
                                Font.custom("Nunito", size: 22)
                                    .weight(.semibold)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.primaryGreen)
                    }
                    .padding(.top)
                    
                    NavigationLink(destination: DietView()) {
                        Text("Food Preference")
                            .font(
                                Font.custom("Nunito", size: 22)
                                    .weight(.semibold)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.primaryGreen)
                    }
                    .padding(.top)
                    
                    NavigationLink(destination: GoalView()) {
                        Text("Change Goal")
                            .font(
                                Font.custom("Nunito", size: 22)
                                    .weight(.semibold)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.primaryGreen)
                    }
                    .padding(.top)
                    
                    NavigationLink(destination: PersonalInfoView()) {
                        Text("Personal Information")
                            .font(
                                Font.custom("Nunito", size: 22)
                                    .weight(.semibold)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.primaryGreen)
                    }
                    .padding(.top)
                }
                .padding([.top], 25)
                .listStyle(.plain)
                .foregroundStyle(.primaryGreen)
            }
            .padding([.horizontal])
        }
        
    }
}

#Preview {
    ProfileView()
}
