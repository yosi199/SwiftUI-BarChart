//
//  GraphPointsChart.swift
//  BarChartPOC
//
//  Created by Yosi Mizrachi on 21/02/2021.
//

import SwiftUI

struct GraphPointsChart: View {
        
    let geometryProxy: GeometryProxy
    let sizePadding: CGFloat = 20
    
    let bundle: DataBundle
    
    var color: Color = Color.blue
    var circleSize: CGFloat = 8
    var enabled = false
    
    var body: some View {
        ZStack {
            
            ForEach(0..<(enabled ? bundle.items.count : 0) , id: \.self) { index in
                
                let item = bundle.items[index]
                
                Dot(enabled: enabled,
                    delayMultiplier: index,
                    color: color,
                    item: item,
                    geometryProxy: geometryProxy)
            }
        }
    }
}

struct Dot: View {
    
    var enabled = false
    
    @State var opacity: Double = 0.01
    
    var delayMultiplier: Int
    var color: Color = Color.blue
    var circleSize: CGFloat = 8
    var item: DrawableInfoChartData
    var geometryProxy: GeometryProxy
    
    var body: some View {
        
        Circle()
            .frame(width: circleSize, height: circleSize, alignment: .center)
            .foregroundColor(color)
            .scaleEffect(x: CGFloat(opacity), y: CGFloat(opacity))
            .opacity(opacity)
            .position(x: item.xPosition, y: geometryProxy.getCenterHeight() - item.yPosition)
            .onAppear {
                let animationValue = 0.02 * Double(delayMultiplier)
                withAnimation(.easeIn(duration: animationValue)) {
                    opacity = enabled ? 1 : 0.01
                    let _ = print(opacity)
                }
            }
    }
}
