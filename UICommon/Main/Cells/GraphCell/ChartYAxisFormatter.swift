//
//  ChartXAxisFormatter.swift
//  UICommon
//
//  Created by Михаил Игонин on 04.12.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Charts

class ChartYAxisFormatter: NSObject, IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return String(Int(value))
    }
}
