//
//  LogoutService.swift
//  Services
//
//  Created by Михаил Игонин on 03.12.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Storages

public class LogoutService: LogoutServicing {
    let usersStorage: UsersStorageInput & UsersStorageOutput
    let gamesStorage: GamesStorageInput & GamesStorageOutput
    let authStorage: AuthStorageInput & AuthStorageOutput

    public init(usersStorage: UsersStorageInput & UsersStorageOutput,
                gamesStorage: GamesStorageInput & GamesStorageOutput,
                authStorage: AuthStorageInput & AuthStorageOutput) {
        self.usersStorage = usersStorage
        self.gamesStorage = gamesStorage
        self.authStorage = authStorage
    }

    public func logout() {
        guard let ownUserID = authStorage.getOwnUserID(),
            let ownUser = usersStorage.getUser(withID: ownUserID) else {
                return
        }

        usersStorage.deleteUser(ownUser)
        gamesStorage.deleteAllData()
        authStorage.setUserID(nil)
    }
}
