//
//  UserFriendsConfigurator.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UIKit
import UICommon
import Core
import Services

final class UserFriendsModuleConfigurator {
    let dependencies: UserScenesDependencies
    
    func configure() -> CoordinatableFactoryResult<UserFriendsModuleStartOption, UserFriendsModuleResult> {
        let viewController = UserFriendsViewController()

        let presenter = UserFriendsPresenter()
        presenter.view = viewController
        presenter.errorDescriber = ErrorDescriber()

        let interactor = UserFriendsInteractor()
        interactor.output = presenter
        interactor.userService = dependencies.userService
        interactor.userStorage = dependencies.userStorage

        presenter.interactor = interactor
        presenter.modelBuilder = UserFriendsModelBuilder()
        
        viewController.output = presenter
        viewController.itemsSource = presenter

        return (AnyCoordinatable(presenter), viewController)
    }

    internal init(dependencies: UserScenesDependencies) {
        self.dependencies = dependencies
    }
}
