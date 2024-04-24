//
//  WeightGraph.swift
//  EatWise
//
//  Created by Thusal Athauda on 21/04/2024.
//

import SwiftUI
import Charts

struct WeightGraph: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        if let userModel = userViewModel.userModel {
            let sortedWeightData = userModel.weight.sorted { $0.day < $1.day }
            Chart {
                ForEach(sortedWeightData) { datum in
                    LineMark(x: .value("Date", datum.day, unit: .day), y: .value("Weight", Double(datum.weight) ?? 0.0 ))
                }
                RuleMark(
                    y: .value("Threshold", 75)
                )
                .foregroundStyle(Color.blue)
            }
            .foregroundStyle(.primaryGreen)
            .chartScrollableAxes(.horizontal)
            .chartXVisibleDomain(length: 86400 * 30)
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            .padding()
        } else {
            Text("No weight data available")
                .padding()
        }
    }
}

#Preview {
    WeightGraph()
        .environmentObject(UserViewModel()) // Provide a fresh instance of UserViewModel for preview
}
