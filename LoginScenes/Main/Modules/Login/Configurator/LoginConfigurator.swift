//
//  LoginConfigurator.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UIKit
import UICommon
import Core

final class LoginModuleConfigurator {
    let dependencies: LoginScenesDependencies
    
    func configure() -> CoordinatableFactoryResult<EmptyOption, LoginModuleResult> {
        let viewController = LoginViewController()

        let presenter = LoginPresenter()
        presenter.view = viewController
        presenter.errorDescriber = ErrorDescriber()

        let interactor = LoginInteractor()
        interactor.output = presenter
        interactor.userService = dependencies.userService
        interactor.authStorage = dependencies.authStorage
        interactor.userStorage = dependencies.userStorage

        presenter.interactor = interactor
        viewController.output = presenter

        return (AnyCoordinatable(presenter), viewController)
    }

    internal init(dependencies: LoginScenesDependencies) {
        self.dependencies = dependencies
    }
}
