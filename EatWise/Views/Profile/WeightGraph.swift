//
//  WeightGraph.swift
//  EatWise
//
//  Created by Thusal Athauda on 21/04/2024.
//

import SwiftUI
import Charts

struct WeightGraph: View {
    
    var data = [
        WeightPoint(weight: 87, day: Date(timeIntervalSinceNow: -86400 * 28)),
        WeightPoint(weight: 84, day: Date(timeIntervalSinceNow: -86400 * 21)),
        WeightPoint(weight: 81, day: Date(timeIntervalSinceNow: -86400 * 14)),
        WeightPoint(weight: 78, day: Date(timeIntervalSinceNow: -86400 * 7)),
        WeightPoint(weight: 85, day: Date()),
    ]
    
    var body: some View {
        Chart{
            ForEach(data) { datum in
                LineMark(x: .value("Date", datum.day, unit: .day), y: .value("Weight", datum.weight))
            }
            RuleMark(
                    y: .value("Threshold", 75)
                )
            .foregroundStyle(Color.blue)
        }
        
        .chartScrollableAxes(.horizontal)
        .chartXVisibleDomain(length: 86400*30)
        .chartYAxis{
            AxisMarks(position: .leading)
        }
        //.aspectRatio(1, contentMode: .fit)
        .padding()
    }
}

#Preview {
    WeightGraph()
}
