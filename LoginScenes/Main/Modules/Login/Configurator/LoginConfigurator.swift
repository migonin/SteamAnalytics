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
        presenter.urlDescriber = WebViewLoginURLDescriber()

        presenter.webViewSignInPath = "https://steamcommunity.com/openid/login?openid.claimed_id=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.identity=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.mode=checkid_setup&openid.ns=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0&openid.realm=http%3A%2F%2Flogin%2F&openid.return_to=http%3A%2F%2Flogin%2Floggedin"

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
