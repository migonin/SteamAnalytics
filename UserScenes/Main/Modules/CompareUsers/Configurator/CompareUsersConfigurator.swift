//
//  CompareUsersConfigurator.swift
//  CompareUsersScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UIKit
import UICommon
import Core
import Services

final class CompareUsersModuleConfigurator {
    let dependencies: UserScenesDependencies
    
    func configure() -> CoordinatableFactoryResult<CompareUsersModuleStartOption, CompareUsersModuleResult> {
        let viewController = CompareUsersViewController()

        let presenter = CompareUsersPresenter()
        presenter.view = viewController
        presenter.errorDescriber = ErrorDescriber()

        let interactor = CompareUsersInteractor()
        interactor.output = presenter
        interactor.comparisonService = dependencies.comparisonService

        presenter.interactor = interactor
        var builder = CompareUsersModelBuilder()
        builder.output = presenter

        presenter.modelBuilder = builder
        
        viewController.output = presenter
        viewController.itemsSource = presenter

        return (AnyCoordinatable(presenter), viewController)
    }

    internal init(dependencies: UserScenesDependencies) {
        self.dependencies = dependencies
    }
}
