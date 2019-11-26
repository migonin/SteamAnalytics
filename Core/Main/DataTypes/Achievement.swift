//
//  Achievement.swift
//  Core
//
//  Created by Михаил Игонин on 24.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public struct Achievement {
    public let name: String
    public let displayName: String
    public let description: String
    public let icon: String
    public let iconGray: String

    public init(name: String,
                displayName: String,
                description: String,
                icon: String,
                iconGray: String) {
        self.name = name
        self.displayName = displayName
        self.description = description
        self.icon = icon
        self.iconGray = iconGray
    }
}
