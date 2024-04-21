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
        WeightPoint(weight: 87, day: "21/12/2023"),
        WeightPoint(weight: 87, day: "21/11/2023"),
        WeightPoint(weight: 87, day: "21/11/2023"),
        WeightPoint(weight: 87, day: "21/11/2023"),
        WeightPoint(weight: 87, day: "21/11/2023"),
        WeightPoint(weight: 87, day: "21/12/2023"),
        WeightPoint(weight: 86.8, day: "28/12/2023"),
        WeightPoint(weight: 86.3, day: "04/01/2024"),
        WeightPoint(weight: 86.6, day: "11/01/2024"),
        WeightPoint(weight: 86.1, day: "18/01/2024")
    ]
    
    var body: some View {
        Chart{
            ForEach(data) { datum in
                LineMark(x: .value("Date", datum.day), y: .value("Weight", datum.weight))
            }
        }
        .padding()
        .frame(height: 250)
    }
}

#Preview {
    WeightGraph()
}
