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
    
    var numOfSeparators: Int = 10
    var separatorColor: Color = Color.gray.opacity(1)
    var positiveValueColor: Color = Color.green
    var negativeValueColor: Color = Color.red
    var textColor: Color = Color.primary
    var textSize: CGFloat = 10
    
    
    @State var showItems = false
    @State var opacity = 0.0
    @State var trim = 0.0
    @State var dragValue: DragGesture.Value? = nil
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                GraphChartShape(geometryProxy: geo, items: showItems ? arr : [], dragValue: dragValue, orchestrator: operationOrchestrator)
                    .trim(from: 0, to: CGFloat(trim))
                    .stroke(Color.black, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .bevel))
                    .opacity(opacity)
                    .animation(.linear(duration: 0.5))
                    .gesture(DragGesture().onChanged({ value in
                        print(value)
                        dragValue = value
                    }))
                
                GraphPointsChart(geometryProxy: geo, items: items, dragValue: dragValue)
                    .frame(width: geo.calculate(desiredWidth: 1, in: .local),
                           height: geo.calculate(desiredHeight: 1),
                           alignment: .center)
                    .zIndex(1)
                    .gesture(DragGesture().onChanged({ value in
                        print(value)
                        dragValue = value
                    }))
                    .environmentObject(operationOrchestrator)
                
                Button("Press") {
                    showItems.toggle()
                    opacity = showItems ? 0.2 : 0.0
                    trim = showItems ? 1.0  : 0.0
                }
            }
        }
//        .background(Color.yellow.opacity(0.5))
    }
}
