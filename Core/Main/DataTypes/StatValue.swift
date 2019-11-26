//
//  StatValue.swift
//  Core
//
//  Created by Михаил Игонин on 26.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public struct StatValue {
    public let name: String
    public let date: Date
    public let value: Int

    public init(name: String,
                date: Date,
                value: Int) {
        self.name = name
        self.date = date
        self.value = value
    }
}
