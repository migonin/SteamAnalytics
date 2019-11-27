//
//  UserConfigurator.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UIKit
import UICommon

final class UserModuleConfigurator {
    let dependencies: UserScenesDependencies
    
    func configure() -> CoordinatableFactoryResult<UserModuleStartOption, UserModuleResult> {
        let viewController = UserViewController()

        let presenter = UserPresenter()
        presenter.view = viewController

        let interactor = UserInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter

        return (AnyCoordinatable(presenter), viewController)
    }

    internal init(dependencies: UserScenesDependencies) {
        self.dependencies = dependencies
    }
}
