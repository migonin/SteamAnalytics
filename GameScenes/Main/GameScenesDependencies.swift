//
//  GameScenesDependencies.swift
//  UserScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Storages
import Services

public struct GameScenesDependencies {
    let gameService: GamesServicing
    let gameStorage: GamesStorageOutput

    public init(gameService: GamesServicing,
                gameStorage: GamesStorageOutput) {
        self.gameService = gameService
        self.gameStorage = gameStorage
    }
}
