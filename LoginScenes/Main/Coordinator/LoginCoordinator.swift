//
//  LoginCoordinator.swift
//  LoginScenes
//
//  Created by Михаил Игонин on 30.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import UICommon
import Core

public final class LoginCoordinator: NavigationCoordinator, Coordinatable {
    public typealias InputType = MainCoordinatorStartOption
    public typealias OutputType = LoginCoordinatorResult

    let dependencies: LoginScenesDependencies
    let modulesFactory: LoginModulesFactoring

    public var output: ((LoginCoordinatorResult) -> Void)?

    var startOption: MainCoordinatorStartOption!

    public init(dependencies: LoginScenesDependencies,
                modulesFactory: LoginModulesFactoring,
                navigator: Navigating) {
        self.dependencies = dependencies
        self.modulesFactory = modulesFactory

        super.init(navigator: navigator)
    }

    public func start(with option: MainCoordinatorStartOption, animated: Bool) {
        super.start()

        self.startOption = option

        let (module, presentable) = modulesFactory.makeLoginScreen()

        module.output = { [weak self] result in
            if case let LoginModuleResult.loggedIn(user) = result {
                self?.output?(.loggedIn(user))
            }
        }

        module.start(with: startOption, animated: false)
        push(presentable, animated: false)
    }
}
