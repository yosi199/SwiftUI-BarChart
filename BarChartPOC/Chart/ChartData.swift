//
//  ChartData.swift
//  Finance-SwiftUI
//
//  Created by Yosi Mizrachi on 01/02/2021.
//

import Foundation

protocol ChartData {
    associatedtype T
    var timestamp: Date { get }
    var value: T { get }
}
