//
//  LoginModulesFactory.swift
//  LoginScenes
//
//  Created by Михаил Игонин on 30.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import UICommon

public struct LoginModulesFactory: LoginModulesFactoring {
    let dependencies: LoginScenesDependencies

    public init(dependencies: LoginScenesDependencies) {
        self.dependencies = dependencies
    }

    public func makeLoginScreen() -> CoordinatableFactoryResult<MainCoordinatorStartOption, LoginModuleResult> {
        return LoginModuleConfigurator(dependencies: dependencies).configure()
    }
}
