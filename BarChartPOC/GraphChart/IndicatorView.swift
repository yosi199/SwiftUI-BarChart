//
//  IndicatorView.swift
//  BarChartPOC
//
//  Created by Yosi Mizrachi on 21/02/2021.
//

import SwiftUI

struct IndicatorView: View {
    
    let items: [DrawableInfoChartData]
    let maxHeightWithinBounds: CGFloat
    let maxItem: DoubleChartData
    
    var distanceBetweenDataPoints: CGFloat = 0
    var sidePadding: CGFloat = 20
    
    @State var dragValue: DragGesture.Value!
    @State var dragging = false
    @State var match = false
    @State var xPosition: CGFloat = 0
    @State var yPosition: CGFloat = 0
    @State var labelValue: CGFloat = 0
    
    private let dragGesture: DragGesture = DragGesture(minimumDistance: 10, coordinateSpace: .local)
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                if (dragValue != nil) {
                    DragIndicator(dragValue: dragValue,
                                  dragging: dragging,
                                  padding: sidePadding,
                                  distanceBetweenDataPoints: distanceBetweenDataPoints)
                }
                
                LabelIndicator(match: match,
                               xPos: xPosition,
                               yPos: yPosition,
                               max: maxHeightWithinBounds,
                               labelValue: labelValue,
                               sidePadding: sidePadding)
            }
            .background(dragging ? Color.white.opacity(0.05) : Color.white.opacity(0.01))
            .gesture(dragGesture
                        .onChanged({onChange(value: $0, geo: geo)})
                        .onEnded(onEnded(value:)))
        }
    }
    
    private func onChange(value: DragGesture.Value, geo: GeometryProxy) {
        items.indices.forEach { index in
            let xPos = CGFloat(index) * distanceBetweenDataPoints + sidePadding
            let delta = abs(value.location.x - xPos)
            if (delta < 4) {
                match = true
                xPosition = xPos
                yPosition = items[index].itemYPosition
                labelValue = CGFloat(items[index].item.value)
            }
        }
        dragValue = value
        dragging = true
    }
    
    private func onEnded(value: DragGesture.Value) {
        dragging = false
        match = false
    }
}

struct LabelIndicator: View {
    
    let match: Bool
    let xPos: CGFloat
    let yPos: CGFloat
    let max: CGFloat
    let labelValue: CGFloat
    
    let boxHeight:CGFloat = 20
    
    var width: CGFloat = 70
    var sidePadding: CGFloat = 20
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Rectangle()
                    .foregroundColor(Color(UIColor.systemBackground))
                    .cornerRadius(4)
                
                let text = Text(Double(labelValue).decimalPlacesString(places: 2))
                
                let gradient = LinearGradient(gradient: Gradient(colors: [.red, .orange]),
                                              startPoint: .topLeading,
                                              endPoint: .bottomTrailing)
                
                text.foregroundColor(Color.clear)
                    .overlay(gradient.mask(text.scaledToFit()))
                
                
            }
            .frame(width: width, height: boxHeight, alignment: .center)
            .position(x: xPos - 20, y: findY(geo: geo, for: yPos, max: max))
            .opacity(match ? 1 : 0)
            .padding()
        }
    }
    
    private func findY(geo: GeometryProxy, for itemValue: CGFloat, max: CGFloat) -> CGFloat {
        // The center position
        let startingPosition = geo.getCenterHeight()
        // the position of the actual data value
        
        var position: CGFloat = 0
        // If item is at the top most coordinate on the graph container
        // than show the box in a slightly lower place.
        // Else show above, normally.
        if (itemValue == max) {
            position = startingPosition - itemValue + (boxHeight * 1.5)
        }
        
        else {
            position = startingPosition - itemValue - boxHeight
        }
        
        return position - boxHeight
    }
}

struct DragIndicator: View {
    
    let dragValue: DragGesture.Value
    let dragging: Bool
    let padding: CGFloat
    let distanceBetweenDataPoints: CGFloat
    
    var width: CGFloat = 8
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                let x = dragValue.location.x.clamped(to: 0 + padding...geo.calculate(desiredWidth: 1) - padding - distanceBetweenDataPoints)
                Rectangle()
                    .frame(width: width, height: geo.size.height, alignment: .center)
                    .foregroundColor(Color.white.opacity(0.5))
                    .position(x: x, y: geo.getCenterHeight())
                    .opacity(dragging ? 1 : 0)
            }
        }
    }
}
