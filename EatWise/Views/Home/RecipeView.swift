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
        let meals = userViewModel.mealModel
            ScrollView {
                VStack{
                    VStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(height: 355)
                            .background(
                                AsyncImage(url: URL(string: userViewModel.mealModel[0].image)){ phase in
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
                                Text(meals[0].meal)
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
                    
                    //Spacer()
                    
//                    VStack (alignment: .leading){
//                        Text("Prep time - 7 mins ")
//                            .font(Font.custom("Nunito", size: 20))
//                            .foregroundColor(Color("TextColor"))
//                            .frame(height: 27)
//                            .padding([.horizontal, .top])
//                        
//                        Rectangle()
//                            .foregroundColor(.clear)
//                            .frame(width: 370, height: 1)
//                            .background(Color(red: 0.24, green: 0.38, blue: 0.33))
//                        
//                        Text("Cook time - 8 mins ")
//                            .font(Font.custom("Nunito", size: 20))
//                            .foregroundColor(Color("TextColor"))
//                            .frame(height: 27, alignment: .topLeading)
//                            .padding(.horizontal)
//                        
//                        Rectangle()
//                            .foregroundColor(.clear)
//                            .frame(width: 370, height: 1)
//                            .background(Color(red: 0.24, green: 0.38, blue: 0.33))
//                        
//                        Text("Total time - 15 mins")
//                            .font(Font.custom("Nunito", size: 20))
//                            .foregroundColor(Color("TextColor"))
//                            .frame(height: 27, alignment: .topLeading)
//                            .padding(.horizontal)
//                        
//                        Rectangle()
//                            .foregroundColor(.clear)
//                            .frame(width: 370, height: 1)
//                            .background(Color(red: 0.24, green: 0.38, blue: 0.33))
//                        
//                        Text("1 Serving")
//                            .font(Font.custom("Nunito", size: 20))
//                            .foregroundColor(Color("TextColor"))
//                            .frame(width: 168, height: 27, alignment: .topLeading)
//                            .padding(.horizontal)
//                        
//                        Rectangle()
//                            .foregroundColor(.clear)
//                            .frame(width: 370, height: 1)
//                            .background(Color(red: 0.24, green: 0.38, blue: 0.33))
//                    }
//                    .padding(.bottom)
                    
                    VStack(alignment: .leading){
                        Text("Ingredients")
                            .font(
                                Font.custom("Nunito-Medium", size: 30)
                            )
                            .foregroundColor(Color.primaryGreen)
                            .padding([.bottom], 5)
                        
                        Text(meals[0].ingredients.split(separator: "\\").joined(separator: "\n"))
                            .font(Font.custom("Nunito", size: 20))
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
                                Font.custom("Nunito-Medium", size: 30)
                            )
                            .foregroundColor(Color.primaryGreen)
                            .padding([.bottom], 5)
                        
                        Text(meals[0].recipe.split(separator: "\\").joined(separator: "\n"))
                            .font(Font.custom("Nunito", size: 20))
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

#Preview {
    RecipeView()
}
