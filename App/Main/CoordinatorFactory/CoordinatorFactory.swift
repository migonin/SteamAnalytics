//
//  CoordinatorFactory.swift
//  SteamAnalyticsApp
//
//  Created by Михаил Игонин on 30.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import UICommon
import LoginScenes
import UserScenes

class CoordinatorFactory: CoordinatorFactoring {
    func makeLoginCoordinator(navigator: Navigating) ->
        CoordinatableFactoryResult<EmptyOption, LoginCoordinatorResult> {

            let dependencies = LoginScenesDependencies(
                userService: Services.usersService,
                userStorage: Storages.usersStorage,
                authStorage: Storages.authStorage
            )

            let modulesFactory = LoginModulesFactory(dependencies: dependencies)

            let coordinator = LoginCoordinator(
                dependencies: dependencies,
                modulesFactory: modulesFactory,
                navigator: navigator)

            return (AnyCoordinatable(coordinator), navigator)
    }

    func makeUserCoordinator(navigator: Navigating) ->
        CoordinatableFactoryResult<UserCoordinatorStartOption, UserCoordinatorResult> {

            let dependencies = UserScenesDependencies(
                userService: Services.usersService,
                userStorage: Storages.usersStorage,
                gameService: Services.gamesService,
                gameStorage: Storages.gamesStorage,
                authStorage: Storages.authStorage
            )

            let modulesFactory = UserModulesFactory(dependencies: dependencies)

            let coordinator = UserCoordinator(
                dependencies: dependencies,
                modulesFactory: modulesFactory,
                coordinatorsFactory: self,
                navigator: navigator)

            return (AnyCoordinatable(coordinator), navigator)
    }

    func makeGameCoordinator(navigator: Navigating) ->
        CoordinatableFactoryResult<GameCoordinatorStartOption, EmptyOption> {

            fatalError()
    }
}
