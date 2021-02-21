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
    
    var items: [DoubleChartData]
    var count: Double = 0
    var opacity: Double =  0.0
    var dragValue: DragGesture.Value? = nil
    
    init(geometryProxy: GeometryProxy, items: [DoubleChartData], dragValue: DragGesture.Value?, orchestrator: OperationOrchestrator) {
        self.geometryProxy = geometryProxy
        self.items = items
        self.count = Double(items.count)
        self.dragValue = dragValue
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
        
        if (!items.isEmpty) {
            let dataPointsCount = items.count
            let distanceBetweenDataPoints = (rect.maxX - (sizePadding * 2)) / CGFloat(dataPointsCount)
            // find the item with the maximum value
            let max = items.max { (a, b) -> Bool in abs(a.value) < abs(b.value) }!
            
            for index in 0..<Int(count) {
                let item = items[index]
                let dataPointHeight = calculateItemHeight(item: item, max: max, rect: rect)
                let xPos = CGFloat(index) * distanceBetweenDataPoints + sizePadding
                if (index == 0) {
                    path.move(to: CGPoint(x: xPos, y: rect.midY - dataPointHeight))
                } else {
                    path.addLine(to: CGPoint(x: xPos, y: rect.midY - dataPointHeight))
                }
                
                orchestrator.index += 1
                
//                guard let dragLocation =
//                if (abs(xPos - (dragValue?.location.x)!) < 3) {
//                    print("Found")
//                }
            
            }
        }
        
        return path
    }
    
    private func calculateItemHeight(item: DoubleChartData, max: DoubleChartData, rect: CGRect) -> CGFloat {
        let maximumAbsoluteValue = abs(max.value)
        let result = ((CGFloat(item.value)) / CGFloat(maximumAbsoluteValue)) * rect.size.height
        #if DEBUG
        print("Result for original value of \(item.value) when max is \(maximumAbsoluteValue) and height is \(rect.size.height) is \(result)")
        #endif
        return result / 2
    }
}
