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
                    Spacer()
                    BarChartView(items: arr, barsLimit: 31)
                        .frame(width: geo.calculate(desiredWidth: 1, in: .local), height: 250, alignment: .center)
//                        .background(Color.red.opacity(0.2))
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
