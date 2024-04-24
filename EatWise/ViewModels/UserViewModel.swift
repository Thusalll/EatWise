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
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    init(userSession: FirebaseAuth.User? = nil, userModel: UserModel? = nil) {
        self.userSession = userSession
        self.userModel = userModel
    }
    
    func logIn (withEmail email: String, password: String) async throws {
         
    }
    
    func createUser (withEmail email: String, password: String, firstName: String, lastname: String, age: String, height: String, weight: String, bmi: String, bmiMessage: String, goal: String, diet: String, allergies: [String], weightType: String, heightType: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = UserModel(id: result.user.uid, firstName: firstName, lastName: lastname, email: email, password: password, age: age, weight: weight, height: height, bmi: bmi, bmiMessage: bmiMessage, diet: diet, goal: goal, allergies: allergies, weightType: weightType, heightType: heightType)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut () {
        
    }
    
    func fetchUser() async {
        
    }
    
}

