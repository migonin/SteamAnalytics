//
//  GameAchievementsConfigurator.swift
//  GameAchievementsScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UIKit
import UICommon
import Core
import Services

final class GameAchievementsModuleConfigurator {
    let dependencies: GameScenesDependencies
    
    func configure() -> CoordinatableFactoryResult<GameAchievementsModuleStartOption, GameAchievementsModuleResult> {
        let viewController = GameAchievementsViewController()

        let presenter = GameAchievementsPresenter()
        presenter.view = viewController
        presenter.errorDescriber = ErrorDescriber()

        let interactor = GameAchievementsInteractor()
        interactor.output = presenter
        interactor.gamesService = dependencies.gameService
        interactor.gamesStorage = dependencies.gameStorage

        presenter.interactor = interactor
        var builder = GameAchievementsModelBuilder()
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
