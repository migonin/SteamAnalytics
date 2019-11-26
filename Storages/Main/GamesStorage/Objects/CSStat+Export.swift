//
//  CSStatValue+Export.swift
//  Storages
//
//  Created by Михаил Игонин on 24.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

extension CSStat {
    public func toStat() -> Stat {
        return Stat(name: self.name.value,
                    displayName: self.displayName.value)
    }
}
