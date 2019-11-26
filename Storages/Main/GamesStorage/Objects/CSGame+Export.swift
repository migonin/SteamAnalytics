//
//  CSGame+Export.swift
//  Storages
//
//  Created by Михаил Игонин on 24.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

extension CSGame {
    public func toGame() -> Game {
        return Game(id: self.id.value,
                    name: self.name.value,
                    icon: self.iconUrl.value,
                    logo: self.logoUrl.value)
    }
}
