//
//  CoordinatorFactoring.swift
//  UICommon
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public protocol CoordinatorFactoring {
    func makeUserCoordinator(navigator: Navigating) -> CoordinatableFactoryResult<UserCoordinatorStartOption, Void>
    func makeGameCoordinator(navigator: Navigating) -> CoordinatableFactoryResult<GameCoordinatorStartOption, Void>
}
