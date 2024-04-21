//
//  MealCard.swift
//  EatWise
//
//  Created by Thusal Athauda on 21/04/2024.
//

import SwiftUI

struct MealCard: View {
    var title: String
    var totalCalories: String
    var firstImageName: String
    var secondImageName: String
    var firstMeal: String
    var secondMeal: String
    var firstMealInfo: String
    var secondMealInfo: String
    var onTapGesture: () -> Void
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Text(title)
                    .font(Font.custom("Nunito-Bold", size: 30))
                    .multilineTextAlignment(.center)
                //.frame(width: 130, height: 39, alignment: .top)
                
                Spacer()
                
                Image(systemName: "checkmark.circle")
                    .imageScale(.large)
                //.foregroundColor(.green)
                    .padding(.trailing)
                    .onTapGesture {
                        
                    }
                
                Image(systemName: "arrow.counterclockwise")
                    .imageScale(.large)
            }
            
            Text(totalCalories)
                .font(Font.custom("Nunito", size: 14))
                .foregroundColor(Color.gray)
            
            VStack(alignment: .leading){
                HStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 53, height: 50)
                        .background(
                            Image(firstImageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 53, height: 50)
                                .clipped()
                        )
                        .overlay(
                            Rectangle()
                                .inset(by: 1.5)
                                .stroke(Color.primaryGreen, lineWidth: 2)
                        )
                    
                    VStack (alignment: .leading){
                        Text(firstMeal)
                            .font(Font.custom("Nunito", size: 22))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                        
                        Text(firstMealInfo)
                            .font(Font.custom("Nunito", size: 18))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.12, green: 0.12, blue: 0.12).opacity(0.63))
                    }
                }
                .onTapGesture {
                    onTapGesture()
                }
                
                HStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 53, height: 50)
                        .background(
                            Image(secondImageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 53, height: 50)
                                .clipped()
                        )
                        .overlay(
                            Rectangle()
                                .inset(by: 1.5)
                                .stroke(Color("PrimaryGreen"), lineWidth: 2)
                        )
                    
                    VStack (alignment: .leading){
                        Text(secondMeal)
                            .font(Font.custom("Nunito", size: 22))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                        
                        Text(secondMealInfo)
                            .font(Font.custom("Nunito", size: 18))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.12, green: 0.12, blue: 0.12).opacity(0.63))
                    }
                }
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(Color("SecondaryGreen"))
            .cornerRadius(10)
            .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
        }
        .padding(.top)
    }
}

#Preview {
    MealCard(
        title: "Breakfast",
        totalCalories: "500 Calories",
        firstImageName: "eggs-on-toast",
        secondImageName: "eggs-on-toast",
        firstMeal: "Scrambled eggs on toast",
        secondMeal: "Scrambled eggs on toast",
        firstMealInfo: "2 Servings - 380 Calories",
        secondMealInfo: "2 Servings - 380 Calories",
        onTapGesture: {}
    )
}
