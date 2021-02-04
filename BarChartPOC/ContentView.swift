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
            HStack(alignment: .center) {
                VStack(alignment: .center) {
                    BarChartView(items: arr, barsLimit: 31)
                        .frame(width: geo.calculate(desiredWidth: 1, in: .local),
                               height: geo.calculate(desiredHeight: 1),
                               alignment: .center)
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
