//
//  ChartXAxisFormatter.swift
//  UICommon
//
//  Created by Михаил Игонин on 04.12.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Charts

class ChartXAxisFormatter: NSObject {
    fileprivate var dateFormatter: DateFormatter!

    convenience init(dateFormatter: DateFormatter) {
        self.init()
        self.dateFormatter = dateFormatter
    }
}


extension ChartXAxisFormatter: IAxisValueFormatter {

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let date = Date(timeIntervalSinceReferenceDate: value)
        return dateFormatter.string(from: date)
    }

}
