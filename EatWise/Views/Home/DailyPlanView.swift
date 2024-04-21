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
                                .onTapGesture {
                                    Button(action: {
                                        self.showDatePicker = true
                                    }) {
                                        Image(systemName: "calendar")
                                            .foregroundColor(.gray)
                                    }
                                    .sheet(isPresented: $showDatePicker) {
                                        DatePicker("Select a date", selection: self.$selectedDate, displayedComponents: .date)
                                    }
                                }
                            
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
                        .padding(.top)
                        
                        if Calendar.current.isDate(selectedDate, inSameDayAs: Date()) {
                            MealCard(
                                title: "Breakfast",
                                totalCalories: "500 Calories",
                                firstImageName: "eggs-on-toast",
                                secondImageName: "eggs-on-toast",
                                firstMeal: "Scrambled eggs on toast",
                                secondMeal: "Scrambled eggs on toast",
                                firstMealInfo: "2 Servings - 380 Calories",
                                secondMealInfo: "2 Servings - 380 Calories",
                                onTapGesture: {
                                    print("Tapped")
                                    presentNextView.toggle()
                                }
                            )
                            
                            MealCard(
                                title: "Lunch",
                                totalCalories: "500 Calories",
                                firstImageName: "eggs-on-toast",
                                secondImageName: "eggs-on-toast",
                                firstMeal: "Scrambled eggs on toast",
                                secondMeal: "Scrambled eggs on toast",
                                firstMealInfo: "2 Servings - 380 Calories",
                                secondMealInfo: "2 Servings - 380 Calories",
                                onTapGesture: {
                                    
                                }
                            )
                            
                            MealCard(
                                title: "Dinner",
                                totalCalories: "500 Calories",
                                firstImageName: "eggs-on-toast",
                                secondImageName: "eggs-on-toast",
                                firstMeal: "Scrambled eggs on toast",
                                secondMeal: "Scrambled eggs on toast",
                                firstMealInfo: "2 Servings - 380 Calories",
                                secondMealInfo: "2 Servings - 380 Calories",
                                onTapGesture: {
                                    
                                }
                            )
                            
                            MealCard(
                                title: "Snack",
                                totalCalories: "500 Calories",
                                firstImageName: "eggs-on-toast",
                                secondImageName: "eggs-on-toast",
                                firstMeal: "Scrambled eggs on toast",
                                secondMeal: "Scrambled eggs on toast",
                                firstMealInfo: "2 Servings - 380 Calories",
                                secondMealInfo: "2 Servings - 380 Calories",
                                onTapGesture: {
                                    
                                }
                            ).padding(.bottom)
                        } else if Calendar.current.isDate(selectedDate, inSameDayAs: Calendar.current.date(byAdding: .day, value: 1, to: Date())!) {
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
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
                        }
                    }else{
                        WeeklyPlanView()
                        //.padding(.horizontal)
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
                                    print(selectedDate)
                                    // Action
                                } label: {
                                    // 1
                                    HStack {
                                        Image(systemName: "arrow.2.circlepath")
                                        
                                        Text("Regenerate All")
                                            .font(
                                                Font.custom("Nunito", size: 16)
                                                    .weight(.bold)
                                            )
                                            .foregroundColor(.white)
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
