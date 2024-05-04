//
//  RecipeView.swift
//  EatWise
//
//  Created by Thusal Athauda on 21/04/2024.
//

import SwiftUI

struct RecipeView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        if let selectedMeal = userViewModel.selectedMeal {
            ScrollView {
                VStack{
                    VStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(height: 355)
                            .background(
                                AsyncImage(url: URL(string: selectedMeal.image)){ phase in
                                    // You can add placeholder or progress view here
                                    // Example:
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 430, height: 355)
                                            .clipped()
                                    } else if phase.error != nil {
                                        // Handle error
                                    } else {
                                        // Handle loading state
                                        ProgressView()
                                    }
                                }
                                .clipped()
                            )
                            .overlay(
                                Text(selectedMeal.meal)
                                    //.frame(height: 55)
                                    .background(.black.opacity(0.17))
                                    .font(
                                        Font.custom("Nunito", size: 34)
                                            .weight(.semibold)
                                    )
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                ,alignment: .bottomLeading
                            )
                        
                    }
                    .frame(height: 355)
                    .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
                    
                    VStack(alignment: .leading){
                        Text("Nutrition Information")
                            .font(
                                Font.custom("Nunito-Medium", size: 28)
                            )
                            .foregroundColor(Color.primaryGreen)
                            .padding([.bottom], 5)
                        HStack{
                            Text("Calories - \(selectedMeal.calories)")
                                .font(Font.custom("Nunito", size: 18))
                                .foregroundColor(.black)
                            Spacer()
                            Text("Carbs - \(selectedMeal.carbs)g")
                                .font(Font.custom("Nunito", size: 18))
                                .foregroundColor(.black)
                        }.padding(.horizontal, 20)
                        HStack{
                            Text("Fat - \(selectedMeal.fat)g")
                                .font(Font.custom("Nunito", size: 18))
                                .foregroundColor(.black)
                            Spacer()
                            Text("Protein - \(selectedMeal.protein)g")
                                .font(Font.custom("Nunito", size: 18))
                                .foregroundColor(.black)
                        }.padding(.horizontal, 20)

                    }
                    .padding()
                    .frame(width: 370, alignment: .leading)
                    .background(Color("SecondaryGreen"))
                    .cornerRadius(10)
                    .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
                    
                    VStack(alignment: .leading){
                        Text("Ingredients")
                            .font(
                                Font.custom("Nunito-Medium", size: 28)
                            )
                            .foregroundColor(Color.primaryGreen)
                            .padding([.bottom], 5)
                        
                        Text(selectedMeal.ingredients.split(separator: "\\").joined(separator: "\n"))
                            .font(Font.custom("Nunito", size: 18))
                            .foregroundColor(.black)
                    }
                    .padding()
                    .frame(width: 370, alignment: .leading)
                    .background(Color("SecondaryGreen"))
                    .cornerRadius(10)
                    .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
                    
                    VStack(alignment: .leading){
                        Text("Instructions")
                            .font(
                                Font.custom("Nunito-Medium", size: 28)
                            )
                            .foregroundColor(Color.primaryGreen)
                            .padding([.bottom], 5)
                        
                        Text(selectedMeal.recipe.split(separator: "\\").joined(separator: "\n\n"))
                            .font(Font.custom("Nunito", size: 18))
                            .foregroundColor(.black)
                    }
                    .padding()
                    .frame(width: 370, alignment: .leading)
                    .background(Color("SecondaryGreen"))
                    .cornerRadius(10)
                    .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
                    
                    //Spacer()
                }
            }
            .ignoresSafeArea()

        }

    }
}

#Preview {
    RecipeView()
}
