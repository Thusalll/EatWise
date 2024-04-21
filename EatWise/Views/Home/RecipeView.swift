//
//  RecipeView.swift
//  EatWise
//
//  Created by Thusal Athauda on 21/04/2024.
//

import SwiftUI

struct RecipeView: View {
    var body: some View {
        ScrollView {
            VStack{
                VStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(height: 355)
                        .background(
                            Image("eggs-on-toast")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 430, height: 355)
                                .clipped()
                        )
                        .overlay(
                            Text("Scrambled Egg on Toast")
                                //.frame(height: 55)
                                .background(.black.opacity(0.17))
                                .font(
                                    Font.custom("Nunito", size: 34)
                                        .weight(.semibold)
                                )
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                            ,alignment: .bottom
                        )
                    
                }
                .frame(height: 355)
                .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
                
                //Spacer()
                
                VStack (alignment: .leading){
                    Text("Prep time - 7 mins ")
                        .font(Font.custom("Nunito", size: 20))
                        .foregroundColor(Color("TextColor"))
                        .frame(height: 27)
                        .padding([.horizontal, .top])
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 370, height: 1)
                        .background(Color(red: 0.24, green: 0.38, blue: 0.33))
                    
                    Text("Cook time - 8 mins ")
                        .font(Font.custom("Nunito", size: 20))
                        .foregroundColor(Color("TextColor"))
                        .frame(height: 27, alignment: .topLeading)
                        .padding(.horizontal)
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 370, height: 1)
                        .background(Color(red: 0.24, green: 0.38, blue: 0.33))
                    
                    Text("Total time - 15 mins")
                        .font(Font.custom("Nunito", size: 20))
                        .foregroundColor(Color("TextColor"))
                        .frame(height: 27, alignment: .topLeading)
                        .padding(.horizontal)
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 370, height: 1)
                        .background(Color(red: 0.24, green: 0.38, blue: 0.33))
                    
                    Text("1 Serving")
                        .font(Font.custom("Nunito", size: 20))
                        .foregroundColor(Color("TextColor"))
                        .frame(width: 168, height: 27, alignment: .topLeading)
                        .padding(.horizontal)
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 370, height: 1)
                        .background(Color(red: 0.24, green: 0.38, blue: 0.33))
                }
                .padding(.bottom)
                
                VStack(alignment: .leading){
                    Text("Ingredients")
                        .font(
                            Font.custom("Nunito-Medium", size: 30)
                        )
                        .foregroundColor(Color.primaryGreen)
                        .padding([.bottom], 5)
                    
                    Text("2 Slices of bread\n1/2 tbsp butter\n2 Eggs\n1/4 Cup feta cheese crumbles")
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
                    
                    Text("1. Spread a thin layer of softened butter on both sides of the bread. Fry the bread over medium heat for about 2 minutes on each side, until a golden brown crust forms. Alternatively, you can use a toaster or toaster oven to toast your bread.\n\n2. Remove the bread from the frying pan and add ½ tbsp. of butter. Add the eggs and feta cheese and cook on medium-low heat, stirring often, for about 3-4 minutes, until the eggs are cooked through. \n\n3. Divide the eggs between the bread slices and sprinkle them with freshly chopped dill or parsley.")
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
