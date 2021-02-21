//
//  ComparableExt.swift
//  BarChartPOC
//
//  Created by Yosi Mizrachi on 21/02/2021.
//

import Foundation

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}
