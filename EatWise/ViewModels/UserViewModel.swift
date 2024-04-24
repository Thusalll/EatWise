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
        
        Task{
            await fetchUser()
        }
    }
    
    init(userSession: FirebaseAuth.User? = nil, userModel: UserModel? = nil) {
        self.userSession = userSession
        self.userModel = userModel
    }
    
    func logIn (withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("DEBUG: Failed to Log in with error \(error.localizedDescription)")
        }
    }
    
    func createUser (withEmail email: String, password: String, firstName: String, lastname: String, age: String, height: String, weight: String, bmi: String, bmiMessage: String, goal: String, diet: String, allergies: [String], weightType: String, heightType: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = UserModel(id: result.user.uid, firstName: firstName, lastName: lastname, email: email, password: password, age: age, weight: weight, height: height, bmi: bmi, bmiMessage: bmiMessage, diet: diet, goal: goal, allergies: allergies, weightType: weightType, heightType: heightType)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut () {
        do{
            try Auth.auth().signOut()
            self.userSession = nil // wipes out user session and navigates to the login view
            self.userModel = nil // wipes out current user data
        } catch{
            print("DEBUG: FAILED TO SIGN OUT WITH ERROR - \(error.localizedDescription)")
        }
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}
        self.userModel = try? snapshot.data(as: UserModel.self)
        
        //print("DEBUG: Current user is \(self.userModel)")
    }
    
}

