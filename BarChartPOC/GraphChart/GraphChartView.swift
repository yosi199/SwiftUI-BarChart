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
    
    @State var bundle = DataBundle()
    
    var body: some View {
        ZStack {
            GeometryReader { geo in

                GraphChartShape(geometryProxy: geo,
                                bundle: bundle,
                                orchestrator: operationOrchestrator)
                    .trim(from: 0, to: CGFloat(trim))
                    .stroke(Color.white, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .bevel))
                    .opacity(opacity)
                    .animation(.linear(duration: 0.5))
                
                GraphPointsChart(geometryProxy: geo,
                                 bundle: bundle,
                                 color: .white,
                                 enabled: showItems)
                    .frame(width: geo.calculate(desiredWidth: 1, in: .local),
                           height: geo.calculate(desiredHeight: 1),
                           alignment: .center)
                    .zIndex(1)
                    .environmentObject(operationOrchestrator)
                
                IndicatorView(bundle: bundle)
                    .zIndex(2)
                    .frame(width: geo.calculate(desiredWidth: 1), height: geo.calculate(desiredHeight: 1), alignment: .center)
                
                
                Button("Press") {
                    
                    bundle = DataBundle()
                    
                    // Trim the items to the amount that was passed in.
                    let trimmedItems = items.suffix(barsLimit == 0 ? items.count : barsLimit) as Array<DoubleChartData>
                    
                    // Calculate distance between each point
                    let distance = (geo.size.width) / CGFloat(trimmedItems.count - 1)
                    
                    //                    // Find the item with the maximum value
                    let max = trimmedItems.max { (a, b) -> Bool in abs(a.value) < abs(b.value) }!
                    
                    
                    bundle.distanceBetweenItems = distance
                    bundle.maxHeightWithinBounds = calculateItemHeight(item: max, max: max, geo: geo)
                    
                    for index in 0..<trimmedItems.count {
                        let item = trimmedItems[index]
                        
                        var bundleItem = DrawableInfoChartData()
                        
                        bundleItem.data = item
                        bundleItem.xPosition = CGFloat(index) * distance
                        bundleItem.yPosition = calculateItemHeight(item: item, max: max, geo: geo)
                        
                        // Set max in the bundle
                        if (item.value == max.value) {
                            bundle.maxItem = bundleItem
                        }
                        
                        bundle.items.append(bundleItem)
                    }
                    
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

struct DataBundle {
    // items
    var items: [DrawableInfoChartData] = []
    var maxItem: DrawableInfoChartData = DrawableInfoChartData()
    // measurements
    var distanceBetweenItems: CGFloat = 0.0
    var maxHeightWithinBounds: CGFloat = 0.0
    
}

struct DrawableInfoChartData: Identifiable, Equatable {
    let id = UUID()
    
    
    var data: DoubleChartData = DoubleChartData(timestamp: Date(),value: 0)
    var yPosition: CGFloat = 0.0
    var xPosition: CGFloat = 0.0
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
