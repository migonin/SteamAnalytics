//
//  Game.swift
//  Core
//
//  Created by Михаил Игонин on 23.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public struct Game: Hashable {
    public let id: Int
    public let name: String
    public let icon: String
    public let logo: String
    public let totalPlaytime: Int
    public let playtimeTwoWeeks: Int

    public init(id: Int,
                name: String,
                icon: String,
                logo: String,
                totalPlaytime: Int,
                playtimeTwoWeeks: Int) {
        self.id = id
        self.name = name
        self.icon = icon
        self.logo = logo
        self.totalPlaytime = totalPlaytime
        self.playtimeTwoWeeks = playtimeTwoWeeks
    }

    public var hashValue: Int {
        return id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
