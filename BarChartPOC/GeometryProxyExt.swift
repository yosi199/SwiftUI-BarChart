//
//  GeometryProxyExt.swift
//  BarChartPOC
//
//  Created by Yosi Mizrachi on 03/02/2021.
//

import Foundation
import SwiftUI

extension GeometryProxy {
    
    func calculate(desiredWidth: CGFloat, in coordinateSpace: CoordinateSpace = .global) -> CGFloat {
        let width = self.frame(in: coordinateSpace).width * desiredWidth
        print("Calculated desired width of: \(width)")
        return width
    }
    
    func calculate(desiredHeight: CGFloat, in coordinateSpace: CoordinateSpace = .global) -> CGFloat {
        let height = self.frame(in: coordinateSpace).height * desiredHeight
        print("Calculated desired height of: \(height)")
        return height
    }
    
    func getCenterWidth(in coordinateSpace: CoordinateSpace = .global) -> CGFloat {
        return self.frame(in: coordinateSpace).width / 2
    }
    
    func getCenterHeight(in coordinateSpace: CoordinateSpace = .global) -> CGFloat {
        return self.frame(in: coordinateSpace).height / 2
    }
}
