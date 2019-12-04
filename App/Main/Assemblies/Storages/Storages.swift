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
                    Entity<CSUser>("User"),
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

    public static let gamesStorage: GamesStorageInput & GamesStorageOutput = {
        let dataStack = DataStack(
            CoreStoreSchema(
                modelVersion: "V1",
                entities: [
                    Entity<CSGameOwner>("CSGameOwner"),
                    Entity<CSGame>("CSGame"),
                    Entity<CSAchievement>("CSAchievement"),
                    Entity<CSAchievementValue>("CSAchievementValue"),
                    Entity<CSStat>("CSStat"),
                    Entity<CSStatValue>("CSStatValue"),
                    Entity<CSPlaytime>("CSPlaytime"),
                ]
            )
        )

        try! dataStack.addStorageAndWait(
            SQLiteStore(
                fileName: "GamesStorage.sqlite",
                localStorageOptions: .recreateStoreOnModelMismatch
            )
        )


        return GamesStorage(dataStack: dataStack)
    }()
}
