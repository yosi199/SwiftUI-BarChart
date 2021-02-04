//
//  BarChartWrapper.swift
//  Finance-SwiftUI
//
//  Created by Yosi Mizrachi on 04/02/2021.
//

import SwiftUI


struct BarChartWrapper: View {
    
//    @FetchRequest(entity: DailyData.entity(), sortDescriptors: []) private var data: FetchedResults<DailyData>

    var body: some View {
//        let items = data.map() {DoubleChartData.init(timestamp: $0.date!, value: $0.value)}
        
        BarChartView(items: arr, barsLimit: 7)
            .padding(20)
    }
}

struct BarChartWrapper_Previews: PreviewProvider {
    static var previews: some View {
        BarChartWrapper()
    }
}
