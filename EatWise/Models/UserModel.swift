//
//  UserModel.swift
//  EatWise
//
//  Created by Thusal Athauda on 22/04/2024.
//

import Foundation

struct UserModel: Codable, Identifiable {
    
    var id: String
    var firstName: String
    var lastName: String
    var email: String
    var password: String
    var age: String
    var weight: [Weight]
    var height: String
    var bmi: String
    var bmiMessage: String
    var diet: String
    var goal: String
    var allergies: [String]?
    var weightType: String
    var heightType: String
}

struct Weight: Codable, Identifiable {
    
    var id: String
    var weight: String
    var day: Date
}
