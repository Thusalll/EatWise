//
//  WeeklyPlanView.swift
//  EatWise
//
//  Created by Thusal Athauda on 21/04/2024.
//

import SwiftUI

struct WeeklyPlanView: View {
    @State private var selectedDate: Date = Date()
    @State private var presentNextView = false
    @EnvironmentObject var userViewModel: UserViewModel
    
    let daysOfWeek: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    let startOfWeek: Date
    
    init() {
        let calendar = Calendar.current
        startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
    }
    
    var body: some View {
        
        ScrollView {
            VStack{
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0..<7) { index in
                            let date = Calendar.current.date(byAdding: .day, value: index, to: self.startOfWeek)!
                            Text(formatDate(date: date))
                                .font(Font.custom("Nunito-Bold", size: 14))
                                .frame(width: 17)
                                .padding()
                                .foregroundStyle(Color.black)
                                .background(self.isSelectedDate(date: date) ? Color.secondaryGreen : Color.gray.opacity(0.5))
                                .clipShape(.circle)
                                .onTapGesture {
                                    self.selectedDate = date
                                }
                        }
                    }
                }
                .scrollIndicators(.hidden )
                .padding(.top)
                
                NutritionCard(
                    title: "2000 Calories",
                    subtitle: "0/2000",
                    progress: 1,
                    progressText: "0%",
                    total: "195g Carbs, 81g Fat, 117g Protein"
                )
                .padding(.top)
                
                if !userViewModel.mealModel.isEmpty{
                    if let firstImageUrl = URL(string: userViewModel.mealModel[0].image){
                        MealCard(
                            title: "Breakfast",
                            totalCalories: "500 Calories",
                            firstImageName: firstImageUrl,
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
                    }
                    
                    if let firstImageUrl = URL(string: userViewModel.mealModel[0].image){
                        MealCard(
                            title: "Breakfast",
                            totalCalories: "500 Calories",
                            firstImageName: firstImageUrl,
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
                    }
                    
                    if let firstImageUrl = URL(string: userViewModel.mealModel[0].image){
                        MealCard(
                            title: "Breakfast",
                            totalCalories: "500 Calories",
                            firstImageName: firstImageUrl,
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
                    }
                    
                    if let firstImageUrl = URL(string: userViewModel.mealModel[0].image){
                        MealCard(
                            title: "Breakfast",
                            totalCalories: "500 Calories",
                            firstImageName: firstImageUrl,
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
                    }
                }
            }
            .sheet(isPresented: $presentNextView) {
                RecipeView()
        }
        }
    }
    private func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: date)
    }
    
    private func isSelectedDate(date: Date) -> Bool {
        return Calendar.current.isDate(self.selectedDate, inSameDayAs: date)
    }
}

#Preview {
    WeeklyPlanView()
}
