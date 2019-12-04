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
import GameScenes
import UIKit

class CoordinatorFactory: CoordinatorFactoring {
    func makeLoginCoordinator() ->
        CoordinatableFactoryResult<EmptyOption, LoginCoordinatorResult> {

            let navController = UINavigationController()
            let navigator = Navigator(rootController: navController)

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

            return (AnyCoordinatable(coordinator), navController)
    }

    func makeTabCoordinator() ->
        CoordinatableFactoryResult<UserCoordinatorStartOption, UserCoordinatorResult> {
            let tabBarController = UITabBarController()
            let coordinator = MainTabBarCoordinator(coordinatorFactory: self, tabBarControlller: tabBarController)

            return (AnyCoordinatable(coordinator), tabBarController)
    }

    func makeUserCoordinator(navigator: Navigating) ->
        CoordinatableFactoryResult<UserCoordinatorStartOption, UserCoordinatorResult> {

            let dependencies = UserScenesDependencies(
                userService: Services.usersService,
                userStorage: Storages.usersStorage,
                gameService: Services.gamesService,
                gameStorage: Storages.gamesStorage,
                authStorage: Storages.authStorage,
                logoutService: Services.logoutService
            )

            let modulesFactory = UserModulesFactory(dependencies: dependencies)

            let coordinator = UserCoordinator(
                dependencies: dependencies,
                modulesFactory: modulesFactory,
                coordinatorsFactory: self,
                navigator: navigator)

            return (AnyCoordinatable(coordinator), navigator)
    }

    func makeGamesCoordinator(navigator: Navigating) ->
        CoordinatableFactoryResult<GamesCoordinatorStartOption, EmptyOption> {

            let dependencies = GameScenesDependencies(gameService: Services.gamesService,
                                                      gameStorage: Storages.gamesStorage)

            let modulesFactory = GameModulesFactory(dependencies: dependencies)

            let coordinator = GamesCoordinator(dependencies: dependencies,
                                              modulesFactory: modulesFactory,
                                              coordinatorsFactory: self,
                                              navigator: navigator)

            return (AnyCoordinatable(coordinator), navigator)
    }
}
