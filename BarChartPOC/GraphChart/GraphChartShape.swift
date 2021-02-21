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
    
    let items: [DrawableInfoChartData]
    let max: DrawableInfoChartData

    var count: Double = 0
    var opacity: Double =  0.0
    var distanceBetweenDataPoints: CGFloat = 0
    
    init(geometryProxy: GeometryProxy,
         items: [DrawableInfoChartData],
         max: DrawableInfoChartData,
         distanceBetweenDataPoints: CGFloat,
         orchestrator: OperationOrchestrator) {
        
        self.geometryProxy = geometryProxy
        self.items = items
        self.max = max
        self.count = Double(items.count)
        self.orchestrator = orchestrator
        self.orchestrator.index = 0
        self.distanceBetweenDataPoints = distanceBetweenDataPoints
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
        
        if (!items.isEmpty) {
            
            for index in 0..<Int(count) {
                let item = items[index]
                let xPos = CGFloat(index) * distanceBetweenDataPoints + sizePadding
                
                if (index == 0) {
                    path.move(to: CGPoint(x: xPos, y: rect.midY - item.itemYPosition))
                } else {
                    path.addLine(to: CGPoint(x: xPos, y: rect.midY - item.itemYPosition))
                }
                
                orchestrator.index += 1
            }
        }
        
        return path
    }

}
