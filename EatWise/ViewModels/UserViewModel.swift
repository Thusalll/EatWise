//
//  UserViewModel.swift
//  EatWise
//
//  Created by Thusal Athauda on 22/04/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

@MainActor
class UserViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var userModel: UserModel?
    @Published var mealModel: [MealModel] = []
    @Published var mealPlan: [String: [MealModel]] = [:]
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task{
            await fetchUser()
            await fetchMeals()
        }
    }
    
    init(userSession: FirebaseAuth.User? = nil, userModel: UserModel? = nil) {
        self.userSession = userSession
        self.userModel = userModel
    }
    
    // User login function
    func logIn (withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("DEBUG: Failed to Log in with error \(error.localizedDescription)")
        }
    }
    
    // User sign up function
    func createUser (withEmail email: String, password: String, firstName: String, lastname: String, age: String, height: String, weight: [Weight], bmi: String, bmiMessage: String, calories: String, goal: String, diet: String, allergies: [String], weightType: String, heightType: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = UserModel(id: result.user.uid, firstName: firstName, lastName: lastname, email: email, password: password, age: age, weight: weight, height: height, bmi: bmi, bmiMessage: bmiMessage, calories: calories, diet: diet, goal: goal, allergies: allergies, weightType: weightType, heightType: heightType)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
            await fetchMeals()
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    // User sign out function
    func signOut () {
        do{
            try Auth.auth().signOut()
            self.userSession = nil // wipes out user session and navigates to the login view
            self.userModel = nil // wipes out current user data
        } catch{
            print("DEBUG: FAILED TO SIGN OUT WITH ERROR - \(error.localizedDescription)")
        }
    }
    
    // Fetch user information function
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}
        self.userModel = try? snapshot.data(as: UserModel.self)
        
        //print("DEBUG: Current user is \(self.userModel)")
    }
    
    // Update user weight function
    func updateUserWeight(newWeight: Weight) async {
        guard let userId = userSession?.uid else {
            print("User is not authenticated.")
            return
        }
        
        // Append the new weight to the existing array
        self.userModel?.weight.append(newWeight)
        
        do {
            // Encode the updated user model
            let encodedUser = try Firestore.Encoder().encode(userModel)
            
            // Update the user document in Firestore
            try await Firestore.firestore().collection("users").document(userId).setData(encodedUser)
            
            // Fetch the updated user data
            await fetchUser()
        } catch {
            print("Failed to update user weight: \(error.localizedDescription)")
        }
    }
    
    // Update user goal function
    func updateUserGoal(newGoal: String) async {
        guard let userId = userSession?.uid else {
            print("User is not authenticated.")
            return
        }
        
        // update the new goal
        self.userModel?.goal = newGoal
        
        do {
            // Encode the updated user model
            let encodedUser = try Firestore.Encoder().encode(userModel)
            
            // Update the user document in Firestore
            try await Firestore.firestore().collection("users").document(userId).setData(encodedUser)
            
            // Fetch the updated user data
            await fetchUser()
        } catch {
            print("Failed to update user goal: \(error.localizedDescription)")
        }
    }
    
    // Update user diet function
    func updateUserDiet(newDiet: String) async {
        guard let userId = userSession?.uid else {
            print("User is not authenticated.")
            return
        }
        
        // update the new goal
        self.userModel?.diet = newDiet
        
        do {
            // Encode the updated user model
            let encodedUser = try Firestore.Encoder().encode(userModel)
            
            // Update the user document in Firestore
            try await Firestore.firestore().collection("users").document(userId).setData(encodedUser)
            
            // Fetch the updated user data
            await fetchUser()
        } catch {
            print("Failed to update user diet: \(error.localizedDescription)")
        }
    }
    
    func createMealPlan() -> [String: [MealModel]] {
        // Calculate total calories needed based on user model
        guard let userModel = userModel, let calories = Double(userModel.calories) else {
            print("User model or calories not available.")
            return mealPlan
        }
        
        // Calculate meal plan for each meal type
        let mealTypes = ["breakfast", "lunch", "dinner"]
        for mealType in mealTypes {
            // Filter meals based on meal type
            let mealsForType = mealModel.filter { meal in
                switch mealType {
                case "breakfast":
                    return meal.breakfast ?? false
                case "lunch":
                    return meal.lunch ?? false
                case "dinner":
                    return meal.dinner ?? false
                default:
                    return false
                }
            }

            let _: [String: String?] = [
              "Balanced": "balanced",
              "Vegan": "vegan",
              "Vegetarian": "vegetarian"
            ]

            let mealsForDietAndType = mealsForType.filter { meal in
                guard let userDiet = self.userModel?.diet else {
                    return true // Include if user's diet preference is not specified
                }
                switch userDiet {
                case "Balanced":
                    return meal.balanced == true
                case "Vegan":
                    return meal.vegan == true
                case "Vegetarian":
                    return meal.vegetarian == true
                default:
                    return true // Include if user's diet preference is invalid
                }
            }

            let totalCaloriesForType = mealsForDietAndType.reduce(0.0) { $0 + Double($1.calories) }
            var selectedMeals: [MealModel] = []
            var remainingCalories = calories
            
            // Shuffle the meals for variety
            var shuffledMeals = mealsForDietAndType.shuffled()
            
            // Select up to 2 meals for this meal type
            var closestCaloriesDifference = Double.infinity
            for meal in shuffledMeals {
                if selectedMeals.count < 2 && remainingCalories - Double(meal.calories) >= 0 {
                    selectedMeals.append(meal)
                    remainingCalories -= Double(meal.calories)
                    
                    // Update closestCaloriesDifference if necessary
                    let currentDifference = abs(totalCaloriesForType - (calories - remainingCalories))
                    if currentDifference < closestCaloriesDifference {
                        closestCaloriesDifference = currentDifference
                    }
                }
            }

            mealPlan[mealType] = selectedMeals
//            print("Selected meal: \(selectedMeals)")
//            print("remainingCalories: \(remainingCalories)")
//            print("DIET: \(self.userModel?.diet)")
        }
        
        return mealPlan
    }

    // Fetch meals for each meal type
    func fetchMealsForMealType(mealType: String) async {
        guard let currentUserID = Auth.auth().currentUser?.uid else { return }
        
        let query = Firestore.firestore().collection("meals").whereField(mealType, isEqualTo: true)
        
        do {
            let querySnapshot = try await query.getDocuments()
            for document in querySnapshot.documents {
                if let mealModel = try? document.data(as: MealModel.self) {
                    self.mealModel.append(mealModel)
                }
            }
        } catch {
            print("Error fetching meals for \(mealType): \(error.localizedDescription)")
        }
    }
    
    // Fetch meals for all meal types
    func fetchMeals() async {
        await fetchMealsForMealType(mealType: "breakfast")
        await fetchMealsForMealType(mealType: "lunch")
        await fetchMealsForMealType(mealType: "dinner")
    }
}

