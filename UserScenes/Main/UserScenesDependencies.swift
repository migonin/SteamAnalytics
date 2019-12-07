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

    let comparisonService: UsersComparisonServicing

    let logoutService: LogoutServicing
    let gameStatsSyncService: GameStatsSyncServicing

    public init(userService: UsersServicing,
                userStorage: UsersStorageInput & UsersStorageOutput,
                comparisonService: UsersComparisonServicing,
                logoutService: LogoutServicing,
                gameStatsSyncService: GameStatsSyncServicing) {
        self.userService = userService
        self.userStorage = userStorage
        self.comparisonService = comparisonService
        self.logoutService = logoutService
        self.gameStatsSyncService = gameStatsSyncService
    }
}
