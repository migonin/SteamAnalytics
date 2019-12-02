//
//  GameConfigurator.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UIKit
import UICommon
import Core

final class GameModuleConfigurator {
    let dependencies: GameScenesDependencies
    
    func configure() -> CoordinatableFactoryResult<GameModuleStartOption, GameModuleResult> {
        let viewController = GameViewController()

        let presenter = GamePresenter()
        presenter.view = viewController
        presenter.errorDescriber = ErrorDescriber()

        let interactor = GameInteractor()
        interactor.output = presenter
        interactor.gamesService = dependencies.gameService
        interactor.gamesStorage = dependencies.gameStorage

        presenter.interactor = interactor
        presenter.modelBuilder = GameModelBuilder()
        
        viewController.output = presenter
        viewController.itemsSource = presenter

        return (AnyCoordinatable(presenter), viewController)
    }

    internal init(dependencies: GameScenesDependencies) {
        self.dependencies = dependencies
    }
}
