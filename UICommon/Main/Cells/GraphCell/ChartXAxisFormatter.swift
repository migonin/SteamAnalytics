//
//  ChartXAxisFormatter.swift
//  UICommon
//
//  Created by Михаил Игонин on 04.12.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Charts

class ChartXAxisFormatter: NSObject, IAxisValueFormatter {
    let dateFormatter: DateFormatter

    init(dateFormatter: DateFormatter) {
        self.dateFormatter = dateFormatter
        super.init()
    }

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let date = Date(timeIntervalSinceReferenceDate: value)
        return dateFormatter.string(from: date)
    }
}
