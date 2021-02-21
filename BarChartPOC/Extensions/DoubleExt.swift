//
//  DoubleExt.swift
//  Finance-SwiftUI
//
//  Created by Yosi Mizrachi on 31/12/2020.
//

import Foundation

extension Double {
    
    func decimalPlacesString(places: Int) -> String{
        return String(format: "%.\(places)f", self)
    }
}
