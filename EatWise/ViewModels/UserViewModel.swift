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
    @Published var weeklyMealPlan: [String: [MealModel]] = [:]
    @Published var selectedMeal: MealModel?
    let db = Firestore.firestore()
    
    init() {
        self.userSession = Auth.auth().currentUser
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        Task {
            do {
                await fetchUser()
                await fetchMeals()

                // Get the current date
                let currentDate = Date()
                try await retrieveDailyMealPlan(date: currentDate)
                try await retrieveWeeklyMealPlan()
            } catch {
                // Handle potential errors here
            }
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
            let shuffledMeals = mealsForDietAndType.shuffled()
            
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
    
    func generateMealsForMealType(_ mealType: String) -> [MealModel] {
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
        
        var selectedMeals: [MealModel] = []
        var remainingCalories = Double(userModel?.calories ?? "0") ?? 0.0
        
        // Shuffle the meals for variety
        let shuffledMeals = mealsForDietAndType.shuffled()
        
        // Select up to 2 meals for this meal type
        for meal in shuffledMeals {
            if selectedMeals.count < 2 && remainingCalories - Double(meal.calories) >= 0 {
                selectedMeals.append(meal)
                remainingCalories -= Double(meal.calories)
            }
        }
        
        return selectedMeals
    }
    
    // Fetch meals for each meal type
    func fetchMealsForMealType(mealType: String) async {
        guard (Auth.auth().currentUser?.uid) != nil else { return }
        
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
    
    private func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
    
    func generateWeeklyMealPlan() {
        // Generate meal plans for each day of the week
        let mealTypes = ["breakfast", "lunch", "dinner"]
        for dayIndex in 0..<7 {
            var dailyMealPlan: [MealModel] = []
            for mealType in mealTypes {
                // Generate meals for the meal type and add them to the daily meal plan
                let generatedMeals = generateMealsForMealType(mealType)
                // Set the mealType property for each generated meal
                for meal in generatedMeals {
                    meal.mealType = mealType
                    dailyMealPlan.append(meal)
                }
            }
            // Add the daily meal plan to the weekly meal plan
            let dayKey = formatDate(date: Calendar.current.date(byAdding: .day, value: dayIndex, to: Date())!)
            weeklyMealPlan[dayKey] = dailyMealPlan
        }
    }
    
    // Fetch meals for all meal types
    func fetchMeals() async {
        await fetchMealsForMealType(mealType: "breakfast")
        await fetchMealsForMealType(mealType: "lunch")
        await fetchMealsForMealType(mealType: "dinner")
    }
    
    func saveDailyMealPlan(date: Date, mealPlan: [String: [MealModel]]) {
        guard let userId = userModel?.id else {
            print("User ID not found")
            return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        print(dateString)

        let docRef = db.collection("userMeals").document(userId).collection("dailyMealPlans").document(dateString)

        let firestoreMealPlan = mealPlan.mapValues { meals in
            meals.map { $0.dictionaryRepresentation() }
        }

        do {
            try docRef.setData(firestoreMealPlan)
        } catch let error {
            print("Error saving meal plan: \(error)")
        }
    }
    
    func saveWeeklyMealPlan(weeklyMealPlan: [String: [MealModel]]) {
        guard let userId = userModel?.id else {
            print("User ID not found")
            return
        }

        // Prepare weekly plan data (directly update the dictionary)
        var weeklyPlanData: [String: [[String: Any]]] = [:]
        for (day, meals) in weeklyMealPlan {
            weeklyPlanData[day] = meals.map { $0.dictionaryRepresentation() }
        }

        let docRef = db.collection("userMeals").document(userId).collection("weeklyMealPlans").document("currentWeek")

        do {
            try docRef.setData(weeklyPlanData) // Use the prepared weeklyPlanData
        } catch let error {
            print("Error saving weekly meal plan: \(error)")
        }
    }

    func retrieveWeeklyMealPlan() async throws -> [String: [MealModel]] {
        guard let userId = userModel?.id else {
            print("User ID not found")
            return [:] // Return an empty plan
        }

        let docRef = db.collection("userMeals").document(userId).collection("weeklyMealPlans").document("currentWeek")

        do {
            let snapshot = try await docRef.getDocument()
            if snapshot.exists, let data = snapshot.data() {
                if let firestoreMealPlan = data as? [String: [[String: Any]]] {
                    
                    // Convert the retrieved data to your MealModel format
                    let weeklyMealPlan = firestoreMealPlan.mapValues { mealsData in
                        mealsData.compactMap { MealModel(from: $0) }
                    }
                    self.weeklyMealPlan = weeklyMealPlan
                    return weeklyMealPlan
                } else {
                    throw WeeklyPlanError.conversionError
                }
            } else {
                throw WeeklyPlanError.planNotFound
            }
        } catch {
            throw error // Handle or propagate as needed
        }
    }


    // Example of a custom error type
    enum WeeklyPlanError: Error {
        case conversionError
        case planNotFound
    }

    func retrieveDailyMealPlan(date: Date) async throws {
        guard let userId = self.userModel?.id else {
            print("User ID not found")
            return
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        let docRef = db.collection("userMeals").document(userId).collection("dailyMealPlans").document(dateString)

        do {
            let snapshot = try await docRef.getDocument() // Use 'await'
            
            if snapshot.exists {
                if let data = snapshot.data(),
                   let firestoreMealPlan = data as? [String: [[String: Any]]] {

                    let mealPlan = firestoreMealPlan.mapValues { mealsData in
                        mealsData.compactMap { MealModel(from: $0) }
                    }

                    self.mealPlan = mealPlan
                    return // Assuming you want to return here if the data is retrieved
                } else {
                    throw MealPlanError.conversionError // Create a custom error type (explained below)
                }
            } else {
                throw MealPlanError.mealPlanNotFound
            }

        } catch {
            throw error // Propagate or handle the error specifically
        }
    }

    // A simple example of a custom error enum
    enum MealPlanError: Error {
        case conversionError
        case mealPlanNotFound
    }

}

//    func saveMealPlansToFirebase(date: Date, userID: String, dailyPlan: [String: [MealModel]], weeklyPlan: [String: [MealModel]]) {
//        // Get a reference to the Firestore database
//        let db = Firestore.firestore()
//
//        // Create a reference to the user's document in the "userMeals" collection
//        let userMealsRef = db.collection("userMeals").document(userID)
//
//        // Prepare daily plan data with date
//        var dailyPlanData: [[String: Any]] = []
//        for (mealType, meals) in dailyPlan {
//            dailyPlanData.append([
//                "mealType": mealType,
//                "meals": meals.map { $0.dictionaryRepresentation() }
//            ])
//        }
//
//        // Prepare weekly plan data
//        var weeklyPlanData: [String: [[String: Any]]] = [:]
//        for (day, meals) in weeklyPlan {
//            weeklyPlanData[day] = meals.map { $0.dictionaryRepresentation() }
//        }
//
//        // Reference to dailyPlans subcollection
//        let dailyPlansRef = userMealsRef.collection("dailyPlans")
//
//        // Reference to weeklyPlans subcollection
//        let weeklyPlansRef = userMealsRef.collection("weeklyPlans")
//
//        // Query dailyPlans to check if there's an existing document for the given date
//        dailyPlansRef.whereField("date", isEqualTo: Timestamp(date: date)).getDocuments { (snapshot, error) in
//            if let error = error {
//                print("Error querying dailyPlans: \(error)")
//                return
//            }
//
//            // If document exists for the given date, update its data
//            if let document = snapshot?.documents.first {
//                document.reference.setData(["plan": dailyPlanData]) { error in
//                    if let error = error {
//                        print("Error updating daily plan: \(error)")
//                    } else {
//                        print("Daily plan updated successfully")
//                    }
//                }
//            } else {
//                // Otherwise, create a new document for the given date
//                let dailyPlanRef = dailyPlansRef.document()
//                dailyPlanRef.setData(["date": Timestamp(date: date), "plan": dailyPlanData]) { error in
//                    if let error = error {
//                        print("Error saving daily plan: \(error)")
//                    } else {
//                        print("Daily plan saved successfully")
//                    }
//                }
//            }
//        }
//
//        // Create a new document in the weeklyPlans subcollection
//        // You can set a specific document ID here if needed
//        weeklyPlansRef.addDocument(data: ["plan": weeklyPlanData]) { error in
//            if let error = error {
//                print("Error saving weekly plan: \(error)")
//            } else {
//                print("Weekly plan saved successfully")
//            }
//        }
//    }
