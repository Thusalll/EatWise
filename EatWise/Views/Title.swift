//
//  Title.swift
//  EatWise
//
//  Created by Thusal Athauda on 21/04/2024.
//

import SwiftUI

struct Title: View {
    var body: some View {
        HStack {
            Text("EatWise")
              .font(
                Font.custom("Nunito-ExtraBold", size: 74)
              )
              .frame(width: 308, height: 75, alignment: .leading)
              .multilineTextAlignment(.center)
              .foregroundColor(Color("TitleGreen"))
            Spacer()
        }
    }
}


#Preview {
    Title()
}
