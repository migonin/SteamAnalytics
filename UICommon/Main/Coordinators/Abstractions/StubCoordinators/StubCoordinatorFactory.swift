//
//  StubCoordinatorFactory.swift
//  UICommon
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

open class StubCoordinatorFactory: CoordinatorFactoring {
    public func makeLoginCoordinator(navigator: Navigating) -> CoordinatableFactoryResult<EmptyOption, LoginCoordinatorResult> {
        return makeStubCoordinatable(message: "Stub LoginCoordinator", navigator: navigator)
    }

    public func makeUserCoordinator(navigator: Navigating) -> CoordinatableFactoryResult<UserCoordinatorStartOption, UserCoordinatorResult> {
        return makeStubCoordinatable(message: "Stub UserCoordinator", navigator: navigator)
    }

    open func makeGameCoordinator(navigator: Navigating) -> CoordinatableFactoryResult<GameCoordinatorStartOption, EmptyOption> {
        return makeStubCoordinatable(message: "Stub GameCoordinator", navigator: navigator)
    }

    private func makeStubCoordinatable<InputType, OutputType>(message: String, navigator: Navigating)
        -> CoordinatableFactoryResult<InputType, OutputType> {
        return (AnyCoordinatable(StubCoordinator(message: message, navigator: navigator)), navigator)
    }
}
