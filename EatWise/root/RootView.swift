//
//  rootView.swift
//  EatWise
//
//  Created by Thusal Athauda on 23/04/2024.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        Group{
            
            if userViewModel.userSession != nil {
                NavBar()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    RootView().environmentObject(UserViewModel())
}
