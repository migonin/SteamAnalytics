//
//  LoginScenesDependencies.swift
//  LoginScenes
//
//  Created by Михаил Игонин on 30.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Storages
import Services

public struct LoginScenesDependencies {
    let userService: UsersServicing
    let userStorage: UsersStorageOutput
    let authStorage: AuthStorageInput&AuthStorageOutput

    public init(userService: UsersServicing,
                userStorage: UsersStorageOutput,
                authStorage: AuthStorageInput&AuthStorageOutput) {
        self.userService = userService
        self.userStorage = userStorage
        self.authStorage = authStorage
    }
}
