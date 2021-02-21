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
    let distanceBetweenDataPoints: CGFloat

    var items: [DrawableInfoChartData]
    var count: Double = 0

    var color: Color = Color.blue
    var circleSize: CGFloat = 8
        
    var body: some View {
        ZStack{
            if (!items.isEmpty) {
                
                ForEach(0..<items.count) { index in
                    
                    let item = items[index]
        
                    let xPos = CGFloat(index) * distanceBetweenDataPoints + sizePadding
                    Circle()
                        .frame(width: circleSize, height: circleSize, alignment: .center)
                        .foregroundColor(color)
                        .scaleEffect(x: orechastrator.index >  index ? 1: 0.01, y: orechastrator.index >  index ? 1: 0.01)
                        .opacity(orechastrator.index >  index ? 1 : 0)
                        .position(x: xPos, y: geometryProxy.getCenterHeight() - item.itemYPosition)
                        .animation(.spring(response: 0.05 * Double(index)))
                }
            }
        }
    }
}
