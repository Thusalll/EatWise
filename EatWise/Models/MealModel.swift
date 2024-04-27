//
//  MealModel.swift
//  EatWise
//
//  Created by Thusal Athauda on 25/04/2024.
//

import Foundation

class MealModel: Codable, Identifiable {
    var id: String
    var meal: String
    var serving: String
    var calories: Int
    var carbs: Int
    var fat: Int
    var protein: Int
    var image: String
    var diet: [String]?
    var ingredients: String
    var recipe: String
    var breakfast: Bool?
    var lunch: Bool?
    var dinner: Bool?
    var snack: Bool?
    var balanced: Bool?
    var vegan: Bool?
    var vegetarian: Bool?
}

//struct Meal: Codable, Identifiable {
//    
//    var id: String
//    var meal: String
//    var serving: String
//    var calories: Int
//    var carbs: Int
//    var fat: Int
//    var protein: Int
//    var image: String
//    var diet: [String]
//    var ingredients: String
//    var recipe: String
//    var breakfast: Bool
//    var lunch: Bool
//    var dinner: Bool
//    var snack: Bool
//}
