//
//  DateExt.swift
//  BarChartPOC
//
//  Created by Yosi Mizrachi on 03/02/2021.
//

import Foundation

extension Date {
    func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
