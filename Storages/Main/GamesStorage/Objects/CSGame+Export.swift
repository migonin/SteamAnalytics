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
    public func toGame(owner: CSGameOwner) -> Game {
        let playtime = owner.playtimes.first(where: {$0.game.value?.id.value == self.id.value})

        return Game(id: self.id.value,
                    name: self.name.value,
                    icon: self.iconUrl.value,
                    logo: self.logoUrl.value,
                    totalPlaytime: playtime?.total.value ?? 0,
                    playtimeTwoWeeks: playtime?.twoWeeks.value ?? 0)
    }
}
