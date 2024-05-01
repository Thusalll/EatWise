//
//  WeeklyPlanView.swift
//  EatWise
//
//  Created by Thusal Athauda on 21/04/2024.
//

import SwiftUI

struct WeeklyPlanView: View {
    @State private var selectedDateIndex = ""
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var presentNextView = false
    
    let daysOfWeek: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    let startOfWeek: Date
    
    init() {
        let calendar = Calendar.current
        startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
        selectedDateIndex = formatDate(date: Date())
    }
    
    private func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
    
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<7, id: \.self) { index in
                        let date = Calendar.current.date(byAdding: .day, value: index, to: self.startOfWeek)!
                        Button(action: {
                            self.selectedDateIndex = self.formatDate(date: date)
                        }) {
                            Text(self.daysOfWeek[index])
                                .padding(10)
                                .foregroundColor(self.selectedDateIndex == self.formatDate(date: date) ? .white : .primary)
                                .background(self.selectedDateIndex == self.formatDate(date: date) ? Color.primaryGreen : Color.clear)
                                .cornerRadius(8)
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            if let mealsForSelectedDate = userViewModel.weeklyMealPlan[selectedDateIndex] {
                VStack(spacing: 16) {
                    ForEach(mealsForSelectedDate) { meal in
                        if let firstImageURL = URL(string: meal.image) {
                            HStack(spacing: 16) {
                                AsyncImage(url: firstImageURL) { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 80, height: 80)
                                            .clipped()
                                    } else if phase.error != nil {
                                        // Handle error
                                    } else {
                                        ProgressView()
                                    }
                                }
                                .frame(width: 80, height: 80)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(meal.mealType?.capitalized ?? "")
                                        .font(.system(size: 16, weight: .semibold))
                                    Text(meal.meal)
                                        .font(.system(size: 14))
                                    Text("Serving: \(meal.serving) - \(meal.calories) calories")
                                        .font(.system(size: 12))
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                            }
                            .onTapGesture {
                                userViewModel.selectedMeal = meal
                                presentNextView.toggle()
                            }
                            .padding(.horizontal)
                        } else {
                            Text("Invalid image URL")
                                .foregroundColor(.secondary)
                                .padding(.top)
                        }
                    }
                }
            } else {
                Text("No meals available for this date.")
                    .padding()
            }
        }
        .sheet(isPresented: $presentNextView) {
            RecipeView()
        }
        .onAppear {  // Set selectedDateIndex to current date on first appearance
            self.selectedDateIndex = self.formatDate(date: Date())
        }
    }
}

struct WeeklyMealView_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyPlanView()
            .environmentObject(UserViewModel())
    }
}
