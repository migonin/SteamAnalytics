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

public final class LoginCoordinator: BaseCoordinator, Coordinatable {
    public typealias InputType = EmptyOption
    public typealias OutputType = LoginCoordinatorResult

    let dependencies: LoginScenesDependencies
    let modulesFactory: LoginModulesFactoring

    public var output: ((LoginCoordinatorResult) -> Void)?

    public init(dependencies: LoginScenesDependencies,
                modulesFactory: LoginModulesFactoring,
                navigator: Navigating) {
        self.dependencies = dependencies
        self.modulesFactory = modulesFactory

        super.init(navigator: navigator)
    }

    public func start(with option: EmptyOption, animated: Bool) {
        super.start()

        let (module, presentable) = modulesFactory.makeLoginScreen()

        module.output = { [weak self] result in
            if case let LoginModuleResult.loggedIn(user) = result {
                self?.output?(.loggedIn(user))
            }
        }

        module.start(with: .none, animated: false)
        push(presentable, animated: false)
    }
}
