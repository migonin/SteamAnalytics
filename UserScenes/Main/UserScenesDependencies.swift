//
//  UserScenesDependencies.swift
//  UserScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Storages
import Services

public struct UserScenesDependencies {
    let userService: UsersServicing
    let userStorage: UsersStorageInput & UsersStorageOutput

    let gameService: GamesServicing
    let gameStorage: GamesStorageOutput

    let logoutService: LogoutServicing
    let gameStatsSyncService: GameStatsSyncServicing

    public init(userService: UsersServicing,
                userStorage: UsersStorageInput & UsersStorageOutput,
                gameService: GamesServicing,
                gameStorage: GamesStorageOutput,
                logoutService: LogoutServicing,
                gameStatsSyncService: GameStatsSyncServicing) {
        self.userService = userService
        self.userStorage = userStorage
        self.gameService = gameService
        self.gameStorage = gameStorage
        self.logoutService = logoutService
        self.gameStatsSyncService = gameStatsSyncService
    }
}
