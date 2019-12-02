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
    let userStorage: UsersStorageOutput

    let gameService: GamesServicing
    let gameStorage: GamesStorageOutput

    let authStorage: AuthStorageInput&AuthStorageOutput

    public init(userService: UsersServicing,
                userStorage: UsersStorageOutput,
                gameService: GamesServicing,
                gameStorage: GamesStorageOutput,
                authStorage: AuthStorageInput&AuthStorageOutput) {
        self.userService = userService
        self.userStorage = userStorage
        self.gameService = gameService
        self.gameStorage = gameStorage
        self.authStorage = authStorage
    }
}
