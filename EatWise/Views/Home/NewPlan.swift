//
//  NewPlan.swift
//  EatWise
//
//  Created by Thusal Athauda on 21/04/2024.
//

import SwiftUI

struct NewPlan: View {
    @State private var selectedPlanType = 0
    @State private var selectedDate = Date()
    @State private var showDatePicker = false
    @State private var presentNextView = false
    @EnvironmentObject var userViewModel: UserViewModel
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd"
        return formatter
    }()
    
    var body: some View {
        VStack {
            HStack {
                Text("EatWise")
                    .font(
                        Font.custom("Nunito", size: 74)
                            .weight(.heavy)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("TitleGreen"))
                    .frame(width: 305, height: 87, alignment: .leading)
                Spacer()
            }
            Picker("Plan Type", selection: $selectedPlanType) {
                Text("Daily").tag(0)
                Text("Weekly").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.vertical)
            
            HStack {
                Button(action: {
                    self.selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: self.selectedDate)!
                }) {
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .foregroundColor(Color("TextColor"))
                }
                
                Spacer()
                Text(dateFormatter.string(from: selectedDate))
                    .font(
                        Font.custom("Nunito", size: 24)
                            .weight(.bold)
                    )
                
                Spacer()
                Button(action: {
                    self.selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: self.selectedDate)!
                }) {
                    Image(systemName: "chevron.right")
                        .imageScale(.large)
                        .foregroundColor(Color("TextColor"))
                }
            }
            .padding(.top)
            
            NutritionCard(
                title: "2000 Calories",
                subtitle: "0/2000",
                progress: 1,
                progressText: "0%",
                total: "195g Carbs, 81g Fat, 117g Protein"
            )
            .padding(.vertical)
            
            Button(action: {
                _ = userViewModel.createMealPlan()
            }, label: {
                Text("Generate\na New\n Daily Plan")
            })
            .frame(width: 180, height: 226)
            .font(
                Font.custom("Nunito", size: 29)
                    .weight(.semibold)
            )
            .foregroundStyle(.primaryGreen)
            .background(
                Color.secondaryGreen
            )
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .padding([.horizontal])
    }
}

#Preview {
    NewPlan()
}
