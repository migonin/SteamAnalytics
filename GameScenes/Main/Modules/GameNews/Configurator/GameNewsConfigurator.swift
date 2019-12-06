//
//  GameNewsConfigurator.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UIKit
import UICommon
import Core

final class GameNewsModuleConfigurator {
    let dependencies: GameScenesDependencies
    
    func configure() -> CoordinatableFactoryResult<GameNewsModuleStartOption, GameNewsModuleResult> {
        let viewController = GameNewsViewController()

        let presenter = GameNewsPresenter()
        presenter.view = viewController
        presenter.errorDescriber = ErrorDescriber()

        let interactor = GameNewsInteractor()
        interactor.output = presenter
        interactor.gameService = dependencies.gameService
        interactor.gameStorage = dependencies.gameStorage

        presenter.interactor = interactor

        var modelBuilder = GameNewsModelBuilder()
        modelBuilder.htmlConverter = HtmlConverter(screenWidth: UIScreen.main.bounds.size.width)
        presenter.modelBuilder = modelBuilder
        
        viewController.output = presenter
        viewController.itemsSource = presenter

        return (AnyCoordinatable(presenter), viewController)
    }

    internal init(dependencies: GameScenesDependencies) {
        self.dependencies = dependencies
    }
}
