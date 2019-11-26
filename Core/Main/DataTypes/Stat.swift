//
//  StatValue.swift
//  Core
//
//  Created by Михаил Игонин on 24.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public struct Stat {
    public let name: String
    public let displayName: String

    public init(name: String,
                displayName: String) {
        self.name = name
        self.displayName = displayName
    }
}
