//
//  Game.swift
//  Core
//
//  Created by Михаил Игонин on 23.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public struct Game {
    public let id: Int
    public let name: String
    public let icon: String
    public let logo: String

    public init(id: Int,
                name: String,
                icon: String,
                logo: String) {
        self.id = id
        self.name = name
        self.icon = icon
        self.logo = logo
    }
}
