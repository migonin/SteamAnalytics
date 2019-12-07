//
//  StubCoordinatorFactory.swift
//  UICommon
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import UIKit

open class StubCoordinatorFactory: CoordinatorFactoring {
    public func makeLoginCoordinator() -> CoordinatableFactoryResult<MainCoordinatorStartOption, LoginCoordinatorResult> {
        return makeStubCoordinatable(message: "Stub LoginCoordinator", navigator: makeNavigator())
    }

    public func makeGamesCoordinator(navigator: Navigating) -> CoordinatableFactoryResult<GamesCoordinatorStartOption, EmptyOption> {
        return makeStubCoordinatable(message: "Stub GameCoordinator", navigator: makeNavigator())
    }

    public func makeTabCoordinator() -> CoordinatableFactoryResult<UserCoordinatorStartOption, UserCoordinatorResult> {
        return makeStubCoordinatable(message: "Stub TabCoordinator", navigator: makeNavigator())
    }

    public func makeLoginCoordinator(navigator: Navigating) -> CoordinatableFactoryResult<EmptyOption, LoginCoordinatorResult> {
        return makeStubCoordinatable(message: "Stub LoginCoordinator", navigator: navigator)
    }

    public func makeUserCoordinator() -> CoordinatableFactoryResult<UserCoordinatorStartOption, UserCoordinatorResult> {
        return makeUserCoordinator(navigator: makeNavigator())
    }

    public func makeUserCoordinator(navigator: Navigating) -> CoordinatableFactoryResult<UserCoordinatorStartOption, UserCoordinatorResult> {
        return makeStubCoordinatable(message: "Stub UserCoordinator", navigator: navigator)
    }

    private func makeStubCoordinatable<InputType, OutputType>(message: String, navigator: Navigating)
        -> CoordinatableFactoryResult<InputType, OutputType> {
        return (AnyCoordinatable(StubCoordinator(message: message, navigator: navigator)), navigator)
    }

    private func makeNavigator() -> Navigating {
        let navController = UINavigationController()
        return Navigator(rootController: navController)
    }
}
