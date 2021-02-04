//
//  DoubleExt.swift
//  BarChartPOC
//
//  Created by Yosi Mizrachi on 04/02/2021.
//

import Foundation

extension Double {
    
    func decimalPlacesString(places: Int) -> String{
        return String(format: "%.\(places)f", self)
    }
}
