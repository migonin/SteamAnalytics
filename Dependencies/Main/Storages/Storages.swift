//
//  Storages.swift
//  Dependencies
//
//  Created by Михаил Игонин on 20.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Storages
import CoreStore

public final class Storages {
    public static let authStorage: AuthStorageInput & AuthStorageOutput = {
        let dataStack = DataStack(
            CoreStoreSchema(
                modelVersion: "V1",
                entities: [
                    Entity<AuthUserIdHolder>("AuthUserIdHolder"),
                ]
            )
        )

        try! dataStack.addStorageAndWait(
            SQLiteStore(
                fileName: "AuthStorage.sqlite",
                localStorageOptions: .recreateStoreOnModelMismatch
            )
        )


        return AuthStorage(dataStack: dataStack)
    }()

    public static let usersStorage: UsersStorageInput & UsersStorageOutput = {
        let dataStack = DataStack(
            CoreStoreSchema(
                modelVersion: "V1",
                entities: [
                    Entity<User>("User"),
                ]
            )
        )

        try! dataStack.addStorageAndWait(
            SQLiteStore(
                fileName: "UserStorage.sqlite",
                localStorageOptions: .recreateStoreOnModelMismatch
            )
        )


        return UsersStorage(dataStack: dataStack)
    }()
}
