//
//  StridableExt.swift
//  BarChartPOC
//
//  Created by Yosi Mizrachi on 21/02/2021.
//

import Foundation

extension Strideable where Stride: SignedInteger {
    func clamped(to limits: CountableClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}
