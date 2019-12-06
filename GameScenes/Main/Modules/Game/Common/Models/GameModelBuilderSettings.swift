//
//  GameModelBuilderSettings.swift
//  GameScenes
//
//  Created by Михаил Игонин on 01.12.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

struct GameModelBuilderSettings {
    let user: User
    let game: Game
    let stats: [(Stat, StatValue)]
    let gameHasNoStats: Bool
}
