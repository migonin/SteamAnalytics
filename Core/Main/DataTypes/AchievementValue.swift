//
//  Achievement.swift
//  Core
//
//  Created by Михаил Игонин on 24.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public struct AchievementValue {
    public let name: String
    public let date: Date

    public init(name: String, date: Date) {
        self.name = name
        self.date = date
    }
}
