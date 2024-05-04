//
//  DailyPlanView.swift
//  EatWise
//
//  Created by Thusal Athauda on 21/04/2024.
//

import SwiftUI

struct DailyPlanView: View {
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
        NavigationStack {
            ScrollView {
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
                    
                    if selectedPlanType == 0 {
                        HStack {
                            Button(action: {
                                self.selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: self.selectedDate)!
                                Task{
                                    do{
                                        try await userViewModel.retrievePreviousMealPlan(date: self.selectedDate)
                                    }
                                }
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
                        
                        if Calendar.current.isDate(selectedDate, inSameDayAs: Date()) {
                            let mealOrder = ["breakfast", "lunch", "dinner"]
                            ForEach(mealOrder, id: \.self) { mealType in
                                if let meals = userViewModel.mealPlan[mealType], !meals.isEmpty {
                                        if let firstMeal = meals.first, let secondMeal = meals.dropFirst().first {
                                            if let firstImageURL = URL(string: firstMeal.image), let secondImageURL = URL(string: secondMeal.image) {
                                                MealCard(
                                                    title: mealType.capitalized,
                                                    totalCalories: "\(firstMeal.calories + secondMeal.calories) Calories",
                                                    firstImageName: firstImageURL,
                                                    secondImageName: secondImageURL,
                                                    firstMeal: firstMeal.meal,
                                                    secondMeal: secondMeal.meal,
                                                    firstMealInfo: "Serving: \(firstMeal.serving) - \(firstMeal.calories) calories",
                                                    secondMealInfo: "Serving: \(secondMeal.serving) - \(secondMeal.calories) calories",
                                                    onTapGesture: {
                                                        if let firstMeal = meals.first {
                                                            userViewModel.selectedMeal = firstMeal
                                                            presentNextView.toggle()
                                                        }
                                                    },
                                                    onTapGesture2: {
                                                        if let secondMeal = meals.dropFirst().first {
                                                            userViewModel.selectedMeal = secondMeal
                                                            presentNextView.toggle()
                                                        }
                                                    },
                                                    regenerateMeal: {
                                                        userViewModel.mealPlan[mealType] = userViewModel.generateMealsForMealType(mealType)
                                                        userViewModel.saveDailyMealPlan(date: self.selectedDate, mealPlan: userViewModel.mealPlanForNextDay)
                                                    }, 
                                                    markMeal: {}
                                                )
                                                .padding(.top)
                                            } else {
                                                Text("Invalid image URL")
                                                    .foregroundColor(.secondary)
                                                    .padding(.top)
                                            }
                                        }
                                    }  else {
                                    EmptyView()
                                }
                            }
                        }
                        else if Calendar.current.isDate(selectedDate, inSameDayAs: Calendar.current.date(byAdding: .day, value: 1, to: Date())!) {
                            if userViewModel.mealPlanForNextDay.isEmpty{
                                Button(action: {
                                    _ = userViewModel.createMealPlanNextDay()
                                    userViewModel.saveDailyMealPlan(date: self.selectedDate, mealPlan: userViewModel.mealPlanForNextDay)
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
                                .padding(.vertical)
                            } else {
                                let mealOrder = ["breakfast", "lunch", "dinner"]
                                ForEach(mealOrder, id: \.self) { mealType in
                                    if let meals = userViewModel.mealPlanForNextDay[mealType], !meals.isEmpty {
                                        if let firstMeal = meals.first, let secondMeal = meals.dropFirst().first {
                                            if let firstImageURL = URL(string: firstMeal.image), let secondImageURL = URL(string: secondMeal.image) {
                                                MealCard(
                                                    title: mealType.capitalized,
                                                    totalCalories: "\(firstMeal.calories + secondMeal.calories) Calories",
                                                    firstImageName: firstImageURL,
                                                    secondImageName: secondImageURL,
                                                    firstMeal: firstMeal.meal,
                                                    secondMeal: secondMeal.meal,
                                                    firstMealInfo: "Serving: \(firstMeal.serving) - \(firstMeal.calories) calories",
                                                    secondMealInfo: "Serving: \(secondMeal.serving) - \(secondMeal.calories) calories",
                                                    onTapGesture: {
                                                        if let firstMeal = meals.first {
                                                            userViewModel.selectedMeal = firstMeal
                                                            presentNextView.toggle()
                                                        }
                                                    },
                                                    onTapGesture2: {
                                                        if let secondMeal = meals.dropFirst().first {
                                                            userViewModel.selectedMeal = secondMeal
                                                            presentNextView.toggle()
                                                        }
                                                    },
                                                    regenerateMeal: {},
                                                    markMeal: {}
                                                )
                                                .padding(.top)
                                            } else {
                                                Text("Invalid image URL")
                                                    .foregroundColor(.secondary)
                                                    .padding(.top)
                                            }
                                        }
                                    }
                                }
                            }

                        }
                        else if Calendar.current.isDate(selectedDate, inSameDayAs: Calendar.current.date(byAdding: .day, value: -1, to: Date())!) {
                            let mealOrder = ["breakfast", "lunch", "dinner"]
                            ForEach(mealOrder, id: \.self) { mealType in
                                    if let meals = userViewModel.mealPlanForPreviousDay[mealType], !meals.isEmpty {
                                        if let firstMeal = meals.first, let secondMeal = meals.dropFirst().first {
                                            if let firstImageURL = URL(string: firstMeal.image), let secondImageURL = URL(string: secondMeal.image) {
                                                MealCard(
                                                    title: mealType.capitalized,
                                                    totalCalories: "\(firstMeal.calories + secondMeal.calories) Calories",
                                                    firstImageName: firstImageURL,
                                                    secondImageName: secondImageURL,
                                                    firstMeal: firstMeal.meal,
                                                    secondMeal: secondMeal.meal,
                                                    firstMealInfo: "Serving: \(firstMeal.serving) - \(firstMeal.calories) calories",
                                                    secondMealInfo: "Serving: \(secondMeal.serving) - \(secondMeal.calories) calories",
                                                    onTapGesture: {
                                                        if let firstMeal = meals.first {
                                                            userViewModel.selectedMeal = firstMeal
                                                            presentNextView.toggle()
                                                        }
                                                    },
                                                    onTapGesture2: {
                                                        if let secondMeal = meals.dropFirst().first {
                                                            userViewModel.selectedMeal = secondMeal
                                                            presentNextView.toggle()
                                                        }
                                                    },
                                                    regenerateMeal: {},
                                                    markMeal: {}
                                                )
                                                .padding(.top)
                                            } else {
                                                Text("Invalid image URL")
                                                    .foregroundColor(.secondary)
                                                    .padding(.top)
                                            }
                                        }
                                    }
                                }
                            

                        }
                    } else{
                        WeeklyPlanView()
                    }
                    
                }
                
            }
            .scrollIndicators(.hidden )
            .padding([.horizontal])
            .overlay(
                Group{
                    if Calendar.current.isDate(selectedDate, inSameDayAs: Date()){
                        HStack {
                            Spacer()
                            VStack{
                                Button {
                                    if selectedPlanType == 0 {
                                        _ = userViewModel.createMealPlan()
                                        userViewModel.saveDailyMealPlan(date: self.selectedDate, mealPlan: userViewModel.mealPlan)
                                    }
                                    
                                    if selectedPlanType == 1 {
                                        _ = userViewModel.generateWeeklyMealPlan()
                                        userViewModel.saveWeeklyMealPlan(weeklyMealPlan: userViewModel.weeklyMealPlan)
                                    }
                                } label: {
                                    HStack {
                                        Image(systemName: "arrow.2.circlepath")
                                        
                                        if selectedPlanType == 0 {
                                            Text(userViewModel.mealPlan.isEmpty ? "Generate Plan" : "Regenerate All")
                                                .font(
                                                    Font.custom("Nunito", size: 16)
                                                        .weight(.bold)
                                                )
                                                .foregroundColor(.white)
                                        }
                                        if selectedPlanType == 1 {
                                            Text(userViewModel.weeklyMealPlan.isEmpty ? "Generate Plan" : "Regenerate All")
                                                .font(
                                                    Font.custom("Nunito", size: 16)
                                                        .weight(.bold)
                                                )
                                                .foregroundColor(.white)
                                        }

                                    }
                                    .padding()
                                    .background(Color.primaryGreen)
                                    .foregroundColor(.white)
                                    .cornerRadius(25)
                                }
                                .padding([.horizontal, .bottom])
                            }
                        }
                    }
                }
                , alignment: .bottomTrailing
                
            )
        }
        .sheet(isPresented: $presentNextView) {
            RecipeView()
        }
        
    }
}

#Preview {
    DailyPlanView()
}
