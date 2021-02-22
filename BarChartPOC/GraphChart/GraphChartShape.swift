//
//  GraphChartShape.swift
//  BarChartPOC
//
//  Created by Yosi Mizrachi on 17/02/2021.
//

import SwiftUI

struct GraphChartShape: Shape {
    
    let orchestrator: OperationOrchestrator
    
    let geometryProxy: GeometryProxy
    let sizePadding: CGFloat = 20
    
    let bundle: DataBundle
    
    var count: Double = 0
    var opacity: Double =  0.0
    
    init(geometryProxy: GeometryProxy,
         bundle: DataBundle,
         orchestrator: OperationOrchestrator) {
        
        self.bundle = bundle
        self.geometryProxy = geometryProxy
        self.count = Double(bundle.items.count)
        self.orchestrator = orchestrator
        self.orchestrator.index = 0
    }
    
    var animatableData: AnimatablePair<Double, Double> {
        get { AnimatablePair(count, opacity) }
        set {
            count = newValue.first
            opacity = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
//        let _ = print("Called GraphChartShape. Items Count: \(count)")
        
        for index in 0..<Int(count) {
            
            let item = bundle.items[index]
            if (index == 0) {
                path.move(to: CGPoint(x: item.xPosition, y: rect.midY - item.yPosition))
            } else {
                path.addLine(to: CGPoint(x: item.xPosition, y: rect.midY - item.yPosition))
            }
            
            orchestrator.index += 1
        }
        
        return path
    }
    
}
