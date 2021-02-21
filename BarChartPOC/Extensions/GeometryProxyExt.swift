//
//  GeometryProxyExt.swift
//  Finance-SwiftUI
//
//  Created by Yosi Mizrachi on 29/12/2020.
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
