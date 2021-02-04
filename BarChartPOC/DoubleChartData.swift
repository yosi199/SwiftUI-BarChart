//
//  DoubleChartData.swift
//  BarChartPOC
//
//  Created by Yosi Mizrachi on 03/02/2021.
//

import Foundation

struct DoubleChartData: ChartData {
    typealias T = Double

    let id = UUID()
    let timestamp: Date
    let value: Double
}
