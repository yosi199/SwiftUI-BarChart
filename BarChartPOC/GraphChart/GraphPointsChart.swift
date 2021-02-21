//
//  GraphPointsChart.swift
//  BarChartPOC
//
//  Created by Yosi Mizrachi on 21/02/2021.
//

import SwiftUI

struct GraphPointsChart: View {
    
    @State var opacity: Double = 0
    @EnvironmentObject var orechastrator: OperationOrchestrator
    
    let geometryProxy: GeometryProxy
    let sizePadding: CGFloat = 20
    
    var circleSize: CGFloat = 8
    var items: [DoubleChartData]
    var count: Double = 0

    
    var dragValue: DragGesture.Value? = nil
    
    var body: some View {
        ZStack{
            if (!items.isEmpty) {
                let dataPointsCount = items.count
                let distanceBetweenDataPoints = (geometryProxy.size.width - (sizePadding * 2)) / CGFloat(dataPointsCount)
                // find the item with the maximum value
                let max = items.max { (a, b) -> Bool in abs(a.value) < abs(b.value) }!
                
                ForEach(0..<items.count) { index in
                    
                    let item = items[index]
                    let dataPointHeight = calculateItemHeight(item: item, max: max, geo: geometryProxy)
                    let xPos = CGFloat(index) * distanceBetweenDataPoints + sizePadding
                    Circle()
                        .frame(width: circleSize, height: circleSize, alignment: .center)
                        .foregroundColor(Color.blue)
                        .scaleEffect(x: orechastrator.index >  index ? 1: 0.01, y: orechastrator.index >  index ? 1: 0.01)
                        .opacity(orechastrator.index >  index ? 1 : 0)
                        .position(x: xPos, y: geometryProxy.getCenterHeight() - dataPointHeight)
                        .animation(.spring(response: 0.05 * Double(index)))
                }
            }
        }
    }
    
    private func calculateItemHeight(item: DoubleChartData, max: DoubleChartData, geo: GeometryProxy) -> CGFloat {
        let maximumAbsoluteValue = abs(max.value)
        let result = ((CGFloat(item.value)) / CGFloat(maximumAbsoluteValue)) * geo.size.height
        #if DEBUG
        print("Result for original value of \(item.value) when max is \(maximumAbsoluteValue) and height is \(geo.size.height) is \(result)")
        #endif
        return result / 2
    }
}
