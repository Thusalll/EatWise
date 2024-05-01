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
    var mealType: String?

    func dictionaryRepresentation() -> [String: Any] {
        return [
            "id": id,
            "meal": meal,
            "serving": serving,
            "calories": calories,
            "carbs": carbs,
            "fat": fat,
            "protein": protein,
            "image": image,
            "diet": diet ?? [],
            "ingredients": ingredients,
            "recipe": recipe,
            "breakfast": breakfast ?? false,
            "lunch": lunch ?? false,
            "dinner": dinner ?? false,
            "snack": snack ?? false,
            "balanced": balanced ?? false,
            "vegan": vegan ?? false,
            "vegetarian": vegetarian ?? false,
            "mealType": mealType ?? ""
        ]
    }

    // Initializer to create a MealModel from a Firestore dictionary
    init?(from dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? String,
              let meal = dictionary["meal"] as? String,
              let serving = dictionary["serving"] as? String,
              let calories = dictionary["calories"] as? Int,
              let carbs = dictionary["carbs"] as? Int,
              let fat = dictionary["fat"] as? Int,
              let protein = dictionary["protein"] as? Int,
              let image = dictionary["image"] as? String,
              let ingredients = dictionary["ingredients"] as? String,
              let recipe = dictionary["recipe"] as? String
        else { return nil }

        // Assign the properties
        self.id = id
        self.meal = meal
        self.serving = serving
        self.calories = calories
        self.carbs = carbs
        self.fat = fat
        self.protein = protein
        self.image = image
        self.diet = dictionary["diet"] as? [String]
        self.ingredients = ingredients
        self.recipe = recipe
        self.breakfast = dictionary["breakfast"] as? Bool
        self.lunch = dictionary["lunch"] as? Bool
        self.dinner = dictionary["dinner"] as? Bool
        self.snack = dictionary["snack"] as? Bool
        self.balanced = dictionary["balanced"] as? Bool
        self.vegan = dictionary["vegan"] as? Bool
        self.vegetarian = dictionary["vegetarian"] as? Bool
        self.mealType = dictionary["mealType"] as? String
    }
}

