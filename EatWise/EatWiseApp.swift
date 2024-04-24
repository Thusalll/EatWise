//
//  EatWiseApp.swift
//  EatWise
//
//  Created by Thusal Athauda on 20/04/2024.
//

import SwiftUI
import Firebase

@main
struct EatWiseApp: App {
    @StateObject var userViewModel = UserViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView().environmentObject(userViewModel)
            //NavBar()
        }
    }
}

