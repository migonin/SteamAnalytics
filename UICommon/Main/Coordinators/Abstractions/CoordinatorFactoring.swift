//
//  CoordinatorFactoring.swift
//  UICommon
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public protocol CoordinatorFactoring {
    func makeLoginCoordinator() ->
        CoordinatableFactoryResult<EmptyOption, LoginCoordinatorResult>

    func makeTabCoordinator() ->
        CoordinatableFactoryResult<UserCoordinatorStartOption, UserCoordinatorResult>

    func makeUserCoordinator(navigator: Navigating) ->
        CoordinatableFactoryResult<UserCoordinatorStartOption, UserCoordinatorResult>

    func makeGamesCoordinator(navigator: Navigating) ->
        CoordinatableFactoryResult<GamesCoordinatorStartOption, EmptyOption>
}
