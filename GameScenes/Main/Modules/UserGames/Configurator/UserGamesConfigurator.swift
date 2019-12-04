//
//  UserGamesConfigurator.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UIKit
import UICommon
import Core

final class UserGamesModuleConfigurator {
    let dependencies: GameScenesDependencies
    
    func configure() -> CoordinatableFactoryResult<UserGamesModuleStartOption, UserGamesModuleResult> {
        let viewController = UserGamesViewController()

        let presenter = UserGamesPresenter()
        presenter.view = viewController
        presenter.errorDescriber = ErrorDescriber()

        let interactor = UserGamesInteractor()
        interactor.output = presenter
        interactor.gameService = dependencies.gameService
        interactor.gameStorage = dependencies.gameStorage

        presenter.interactor = interactor
        presenter.modelBuilder = UserGamesModelBuilder()
        
        viewController.output = presenter
        viewController.itemsSource = presenter

        return (AnyCoordinatable(presenter), viewController)
    }

    internal init(dependencies: GameScenesDependencies) {
        self.dependencies = dependencies
    }
}
