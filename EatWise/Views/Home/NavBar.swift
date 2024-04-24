//
//  NavBar.swift
//  EatWise
//
//  Created by Thusal Athauda on 21/04/2024.
//

import SwiftUI

struct NavBar: View {
    var body: some View {
            TabView {
                Group{
                    DailyPlanView()
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                    ProfileView()
                        .tabItem {
                            Label("Profile", systemImage: "person")
                        }
                }
            }
            .toolbarBackground(.visible, for: .tabBar)
            .accentColor(/*@START_MENU_TOKEN@*/Color("PrimaryGreen")/*@END_MENU_TOKEN@*/)
        
    }
}

#Preview {
    NavBar()
}
