//
//  ContentView.swift
//  BarChartPOC
//
//  Created by Yosi Mizrachi on 03/02/2021.
//

import SwiftUI

struct ContentView: View {
        
    var body: some View {
        GeometryReader { geo in
            let gradient = LinearGradient(gradient: Gradient(colors: [.red, .orange]),
                                          startPoint: .topLeading,
                                          endPoint: .bottomTrailing)
            
            HStack(alignment: .center) {
                VStack(alignment: .center) {
                    Spacer()
                    //                    BarChartView(items: arr, barsLimit: 7)
                    //                        .frame(width: geo.calculate(desiredWidth: 0.8, in: .local),
                    //                               height: geo.calculate(desiredHeight: 0.6),
                    //                               alignment: .center)
                    //                        .background(Color.yellow.opacity(0.5))
                    //
                    //                        .position(x: geo.calculate(desiredWidth: 0.5),
                    //                                  y: geo.calculate(desiredHeight: 1) / 2)
                    
                    GraphChartView(items: arr, barsLimit: 7)
                        .frame(width: geo.calculate(desiredWidth: 0.9, in: .local),
                               height: geo.calculate(desiredHeight: 0.6),
                               alignment: .center)
                        .position(x: geo.calculate(desiredWidth: 0.5),
                                  y: geo.calculate(desiredHeight: 1) / 2)
                    
                    Spacer()
                }
            }
            .background(gradient)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
