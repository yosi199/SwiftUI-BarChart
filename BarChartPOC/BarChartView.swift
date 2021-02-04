//
//  BarChartView.swift
//  BarChartPOC
//
//  Created by Yosi Mizrachi on 03/02/2021.
//

import SwiftUI

struct BarChartView: View {
    
    let items: [DoubleChartData]
    let numOfSeparators: Int
    let separatorColor: Color
    let positiveValueColor: Color
    let negativeValueColor: Color
    let textColor: Color
    
    let chartOffsetValue: CGFloat = 30
    let textSize: CGFloat = 10
    
    @State var animate = false
    
    init(items: [DoubleChartData],
         barsLimit: Int = 0,
         numOfLineSeparators: Int = 10,
         separatorColor: Color = Color.gray.opacity(0.2),
         positiveColor: Color = Color.green,
         negativeColor: Color = Color.red,
         textColor: Color = Color.primary) {
        
        self.items = items.suffix(barsLimit == 0 ? items.count : barsLimit)
        self.numOfSeparators = numOfLineSeparators
        self.separatorColor = separatorColor
        self.positiveValueColor = positiveColor
        self.negativeValueColor = negativeColor
        self.textColor = textColor
    }
    
    var body: some View {
        GeometryReader { geo in
            
            // get the available width we have to use
            let availableWidth = geo.calculate(desiredWidth: 1, in: .local) - chartOffsetValue
            // we need to insert in this available space n amount of items + (n + 1) spaces between them,
            // starting with a space. and ending with a space
            // 0 1 0 1 0 1 0
            let itemWidth = availableWidth / CGFloat(((items.count * 2) + 1))
            // find the item with the maximum value
            let max = items.max { (a, b) -> Bool in abs(a.value) < abs(b.value) }!
            
            // This is the distance for the separator lines as derived from view height
            let separatorsDistance = CGFloat(geo.calculate(desiredHeight: 1)) / CGFloat(numOfSeparators)
            // This is the value needed to be shown on each label in the seperator lines
            let valueForDistance = fabs(max.value) / Double(numOfSeparators / 2)
            
            ZStack {
                
                // Line separators
                ForEach(0..<numOfSeparators + 1) { index in
                    ZStack {
                        // Separator line
                        Rectangle()
                            .foregroundColor(separatorColor)
                            .frame(width: geo.calculate(desiredWidth: 1, in: .local), height: 1, alignment: .center)
                            .position(x: (geo.calculate(desiredWidth: 1, in: .local) / 2) + chartOffsetValue, y: separatorsDistance * CGFloat(index))
                        
                        // Separator text
                        let value = fabs(max.value) - (Double(index) * valueForDistance)
                        Text("\(value.decimalPlacesString(places: 2))%")
                            .multilineTextAlignment(.center)
                            .foregroundColor(textColor)
                            .font(.system(size: textSize))
                            .frame(width: geo.calculate(desiredWidth: 1, in: .local), alignment: .leading)
                            .position(x: geo.calculate(desiredWidth: 1, in: .local) / 2, y: separatorsDistance * CGFloat(index))
                    }
                }
                
                
                HStack(alignment: .center, spacing: 0) {
                    ForEach(items.indices, id: \.self) { index in
                        
                        let item = items[index]
                        let calculatedItemHeight = calculateItemHeight(item: item, max: max, geo: geo)
                        
                        ZStack {
                            HStack {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: itemWidth, height: 100, alignment: .center)
                                
                                Rectangle()
                                    .foregroundColor(calculatedItemHeight > 0 ? positiveValueColor : negativeValueColor)
                                    .frame(width: itemWidth,
                                           height: abs(calculatedItemHeight),
                                           alignment: .center)
                                    .offset(x: CGFloat(chartOffsetValue), y: -CGFloat(calculatedItemHeight) / 2)
                                    .opacity(animate ? 1: 0)
                                    .scaleEffect(y: animate ? 1: 0)
                                    .animation(Animation.spring(response: 0.2 * Double(index + 1)).delay(0.8))
                            }
                            
                            HStack(alignment: .center) {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: itemWidth, height: 100, alignment: .center)
                                Text(item.timestamp.getFormattedDate(format: "MM/dd"))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(textColor)
                                    .font(.system(size: textSize))
                                    .rotationEffect(.degrees(45))
                                    .fixedSize(horizontal: true, vertical: false)
                                    .frame(width: itemWidth * 2, height: 100, alignment: .center)
                                    .offset(x: chartOffsetValue)
                                    .background(Color.clear)
                            }
                            .position(x: itemWidth, y: geo.calculate(desiredHeight: 1))
                            
                        }
//                        .frame(width: itemWidth * 2, alignment: .center)
                        .background(Color.pink.opacity(0.2))
                    }
                }
                .frame(width: geo.calculate(desiredWidth: 1), alignment: .leading)
                .background(Color.yellow.opacity(0.2))
                .zIndex(1)
            }
            
            // Strech to the maximum amount available to us
            .frame(width: geo.calculate(desiredWidth: 1, in: .local) - 100,
                   height: geo.calculate(desiredHeight: 1, in: .local),
                   alignment: .leading)
        }
        .onAppear {
            if (animate == false){
                withAnimation {
                    animate.toggle()
                }
            }
        }
//        .onTapGesture {
//            withAnimation {
//                animate.toggle()
//            }
//        }
    }
    
    private func calculateItemHeight(item: DoubleChartData, max: DoubleChartData, geo: GeometryProxy) -> CGFloat {
        let maximumAbsoluteValue = abs(max.value)
        let availableHeight = geo.calculate(desiredHeight: 1, in: .local)
        let result =  ((CGFloat(item.value)) / CGFloat(maximumAbsoluteValue)) * availableHeight
        #if DEBUG
        print("Result for original value of \(item.value) when max is \(maximumAbsoluteValue) and height is \(availableHeight) is \(result)")
        #endif
        return result / 2
    }
}

struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartView(items: arr)
    }
}
