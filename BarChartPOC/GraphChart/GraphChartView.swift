//
//  GraphChartView.swift
//  BarChartPOC
//
//  Created by Yosi Mizrachi on 17/02/2021.
//

import SwiftUI

struct GraphChartView: View {
    
    let operationOrchestrator = OperationOrchestrator()
    let items: [DoubleChartData]
    
    var barsLimit = 31
    var sizePadding: CGFloat = 20
    
    @State var showItems = false
    @State var opacity = 0.0
    @State var trim = 0.0
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                // Trim the items to the amount that was passed in.
                let trimmedItems = items.suffix(barsLimit == 0 ? items.count : barsLimit) as Array<DoubleChartData>
                
                // Calculate distance between each point
                let distance = (geo.size.width - (sizePadding * 2)) / CGFloat(trimmedItems.count)
                
                // Find the item with the maximum value
                let max = trimmedItems.max { (a, b) -> Bool in abs(a.value) < abs(b.value) }!
                let maxManipulated = DrawableInfoChartData(item: max, itemYPosition: calculateItemHeight(item: max, max: max, geo: geo))
                
                // Find the height of 'max' so we know what is our maximum height inside this container
                let maxHeightWithinBounds = calculateItemHeight(item: max, max: max, geo: geo)
                
                // Pack all the calculated data into a new collection. The goal here is to do calculation pre-render so we
                // will be more efficent.
                let manipulatedData = trimmedItems.map({DrawableInfoChartData(item: $0, itemYPosition: calculateItemHeight(item: $0, max: max, geo: geo))})
                
                
                GraphChartShape(geometryProxy: geo,
                                items: showItems ? manipulatedData : [],
                                max: maxManipulated,
                                distanceBetweenDataPoints: distance,
                                orchestrator: operationOrchestrator)
                    .trim(from: 0, to: CGFloat(trim))
                    .stroke(Color.white, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .bevel))
                    .opacity(opacity)
                    .animation(.linear(duration: 0.5))
                
                GraphPointsChart(geometryProxy: geo,
                                 distanceBetweenDataPoints: distance,
                                 items: manipulatedData,
                                 color: .white)
                    .frame(width: geo.calculate(desiredWidth: 1, in: .local),
                           height: geo.calculate(desiredHeight: 1),
                           alignment: .center)
                    .zIndex(1)
                    .environmentObject(operationOrchestrator)
                
                IndicatorView(items: manipulatedData,
                              maxHeightWithinBounds: maxHeightWithinBounds,
                              maxItem: max,
                              distanceBetweenDataPoints: distance)
                    .zIndex(2)
                    .frame(width: geo.calculate(desiredWidth: 1), height: geo.calculate(desiredHeight: 1), alignment: .center)
                
                
                Button("Press") {
                    showItems.toggle()
                    opacity = showItems ? 0.5 : 0.0
                    trim = showItems ? 1.0  : 0.0
                }
                .zIndex(3)
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

struct DrawableInfoChartData {
    let item: DoubleChartData
    let itemYPosition: CGFloat
}
