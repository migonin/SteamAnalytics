//
//  StatComparison.swift
//  Core
//
//  Created by Михаил Игонин on 07.12.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public struct StatComparison {
    public let stat: Stat
    public let firstValue: Int
    public let secondValue: Int

    public init(stat: Stat, firstValue: Int, secondValue: Int) {
        self.stat = stat
        self.firstValue = firstValue
        self.secondValue = secondValue
    }
}
