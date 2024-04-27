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
    func createUser (withEmail email: String, password: String, firstName: String, lastname: String, age: String, height: String, weight: [Weight], bmi: String, bmiMessage: String, goal: String, diet: String, allergies: [String], weightType: String, heightType: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = UserModel(id: result.user.uid, firstName: firstName, lastName: lastname, email: email, password: password, age: age, weight: weight, height: height, bmi: bmi, bmiMessage: bmiMessage, diet: diet, goal: goal, allergies: allergies, weightType: weightType, heightType: heightType)
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
    
    func fetchMeals() async {
        guard let currentUserUID = Auth.auth().currentUser?.uid else { return }
        
        let query = Firestore.firestore().collection("meals")
            .whereField("dinner", isEqualTo: true)
        var fetchedMealCount = 0 // remove this
        do {
            let querySnapshot = try await query.getDocuments()
            for document in querySnapshot.documents {
                if let mealModels = try? document.data(as: MealModel.self) {
                    // Assign fetched meal to mealModel property
                    self.mealModel.append(mealModels)
                    // Increment the fetched meal count
                    fetchedMealCount += 1
                    
                    print("Meal \(fetchedMealCount): \(mealModels.meal)")
                }
            }
        } catch {
            print("Error fetching meals: \(error.localizedDescription)")
        }
    }

}


