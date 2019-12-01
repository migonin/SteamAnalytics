//
//  CoordinatorFactoring.swift
//  UICommon
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public protocol CoordinatorFactoring {
    func makeLoginCoordinator(navigator: Navigating) ->
        CoordinatableFactoryResult<EmptyOption, LoginCoordinatorResult>
    func makeUserCoordinator(navigator: Navigating) ->
        CoordinatableFactoryResult<UserCoordinatorStartOption, UserCoordinatorResult>
    func makeGameCoordinator(navigator: Navigating) ->
        CoordinatableFactoryResult<GameCoordinatorStartOption, EmptyOption>
}
