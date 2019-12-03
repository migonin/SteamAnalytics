//
//  UserConfigurator.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UIKit
import UICommon
import Core

final class UserModuleConfigurator {
    let dependencies: UserScenesDependencies
    
    func configure() -> CoordinatableFactoryResult<UserModuleStartOption, UserModuleResult> {
        let viewController = UserViewController()

        let presenter = UserPresenter()
        presenter.view = viewController
        presenter.errorDescriber = ErrorDescriber()

        let interactor = UserInteractor()
        interactor.output = presenter
        interactor.userService = dependencies.userService
        interactor.authStorage = dependencies.authStorage
        interactor.userStorage = dependencies.userStorage
        interactor.logoutService = dependencies.logoutService

        presenter.interactor = interactor
        presenter.modelBuilder = UserModelBuilder()
        
        viewController.output = presenter
        viewController.itemsSource = presenter

        return (AnyCoordinatable(presenter), viewController)
    }

    internal init(dependencies: UserScenesDependencies) {
        self.dependencies = dependencies
    }
}
