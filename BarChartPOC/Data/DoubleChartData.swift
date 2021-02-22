//
//  DoubleChartData.swift
//  BarChartPOC
//
//  Created by Yosi Mizrachi on 03/02/2021.
//

import Foundation

struct DoubleChartData: ChartData, Identifiable, Equatable, Hashable { 
    typealias T = Double

    let id = UUID()
    let timestamp: Date
    let value: Double
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
