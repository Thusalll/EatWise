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
    var firstImageName: URL
    var secondImageName: URL
    var firstMeal: String
    var secondMeal: String
    var firstMealInfo: String
    var secondMealInfo: String
    var onTapGesture: () -> Void
    var onTapGesture2: () -> Void
    var regenerateMeal: () -> Void
    
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
                    .onTapGesture {
                        regenerateMeal()
                    }
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
                            AsyncImage(url: firstImageName) { phase in
                                // Handle loading, success, failure states here
                                if let image = phase.image{
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 53, height: 50)
                                        .clipped()
                                } else if phase.error != nil {
                                    // Handle error
                                } else {
                                    // Handle loading state
                                    ProgressView()
                                }
                            }
                        )
                        .overlay(
                            Rectangle()
                                .inset(by: 1.5)
                                .stroke(Color.primaryGreen, lineWidth: 2)
                        )
                    
                    VStack (alignment: .leading){
                        Text(firstMeal)
                            .font(Font.custom("Nunito", size: 20))
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.black)
                        
                        Text(firstMealInfo)
                            .font(Font.custom("Nunito", size: 16))
                            .multilineTextAlignment(.leading)
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
                            AsyncImage(url: secondImageName) { phase in
                                // Handle loading, success, failure states here
                                if let image = phase.image{
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 53, height: 50)
                                        .clipped()
                                } else if phase.error != nil {
                                    // Handle error
                                } else {
                                    // Handle loading state
                                    ProgressView()
                                }
                            }
                        )
                        .overlay(
                            Rectangle()
                                .inset(by: 1.5)
                                .stroke(Color.primaryGreen, lineWidth: 2)
                        )
                    VStack (alignment: .leading){
                        Text(secondMeal)
                            .font(Font.custom("Nunito", size: 20))
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.black)
                        
                        Text(secondMealInfo)
                            .font(Font.custom("Nunito", size: 16))
                            .multilineTextAlignment(.leading)
                            .foregroundColor(Color(red: 0.12, green: 0.12, blue: 0.12).opacity(0.63))
                    }
                }
            }
            .onTapGesture {
                onTapGesture2()
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


