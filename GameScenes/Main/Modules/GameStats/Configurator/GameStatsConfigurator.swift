//
//  GameStatsConfigurator.swift
//  GameStatsScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UIKit
import UICommon
import Core

final class GameStatsModuleConfigurator {
    let dependencies: GameScenesDependencies
    
    func configure() -> CoordinatableFactoryResult<GameStatsModuleStartOption, GameStatsModuleResult> {
        let viewController = GameStatsViewController()

        let presenter = GameStatsPresenter()
        presenter.view = viewController
        presenter.errorDescriber = ErrorDescriber()

        let interactor = GameStatsInteractor()
        interactor.output = presenter
        interactor.gamesService = dependencies.gameService
        interactor.gamesStorage = dependencies.gameStorage

        presenter.interactor = interactor
        var builder = GameStatsModelBuilder()
        builder.output = presenter

        presenter.modelBuilder = builder
        
        viewController.output = presenter
        viewController.itemsSource = presenter

        return (AnyCoordinatable(presenter), viewController)
    }

    internal init(dependencies: GameScenesDependencies) {
        self.dependencies = dependencies
    }
}
