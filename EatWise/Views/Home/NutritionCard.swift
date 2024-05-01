//
//  NutritionCard.swift
//  EatWise
//
//  Created by Thusal Athauda on 21/04/2024.
//

import SwiftUI

struct NutritionCard: View {
    var title: String
    var subtitle: String
    var progress: Double
    var progressText: String
    var total: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image("pie-chart-svg")
                    .resizable()
                    .frame(width: 62, height: 65)
                VStack (alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(Font.custom("Nunito-Bold", size: 20))
                        .foregroundColor(.white)
                    
                    Text(total)
                        .font(Font.custom("Nunito", size: 16))
                        .foregroundColor(.white)
                    
                }
                Spacer()
            }
            .padding(.bottom)
            
            HStack(alignment: .top, spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    
                    ProgressView(value: progress, total: 100)
                        .progressViewStyle(.linear)
                        .tint(Color(red: 0.95, green: 0.86, blue: 0.51))
                    
                    HStack {
                        Text(subtitle)
                            .font(Font.custom("Nunito", size: 16))
                            .foregroundColor(.white)
                        Spacer()
                        Text(progressText)
                            .font(Font.custom("Nunito", size: 16))
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .padding()
        .background(Color("PrimaryGreen"))
        .cornerRadius(10)
        .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}

struct nutritionCard_Previews: PreviewProvider {
    static var previews: some View {
        NutritionCard(
            title: "2000 Calories",
            subtitle: "0/2000",
            progress: 1,
            progressText: "0%",
            total: "195g Carbs, 81g Fat, 117g Protein"
        )
        .previewLayout(.fixed(width: 300, height: 200))
    }
}
