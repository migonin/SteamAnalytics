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
    let userStorage: UsersStorageInput&UsersStorageOutput
    let authStorage: AuthStorageInput&AuthStorageOutput

    public init(userStorage: UsersStorageInput&UsersStorageOutput,
                authStorage: AuthStorageInput&AuthStorageOutput) {
        self.userStorage = userStorage
        self.authStorage = authStorage
    }

    public func logout() {
        guard let ownUserID = authStorage.getOwnUserID(),
            let ownUser = userStorage.getUser(withID: ownUserID) else {
                return
        }

        userStorage.deleteUser(ownUser)
        authStorage.setUserID(nil)
    }
}
