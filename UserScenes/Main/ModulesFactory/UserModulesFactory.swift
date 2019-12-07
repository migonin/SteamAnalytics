//
//  UserModulesFactory.swift
//  UserScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core
import UICommon

public struct UserModulesFactory: UserModulesFactoring {
    let dependencies: UserScenesDependencies

    public init(dependencies: UserScenesDependencies) {
        self.dependencies = dependencies
    }

    public func makeUserScreen() -> CoordinatableFactoryResult<UserModuleStartOption, UserModuleResult> {
        return UserModuleConfigurator(dependencies: dependencies).configure()
    }

    public func makeUserFriendsScreen() -> CoordinatableFactoryResult<UserFriendsModuleStartOption, UserFriendsModuleResult> {
        return UserFriendsModuleConfigurator(dependencies: dependencies).configure()
    }

    public func makeUserComparison() ->
        CoordinatableFactoryResult<CompareUsersModuleStartOption, CompareUsersModuleResult> {
            return CompareUsersModuleConfigurator(dependencies: dependencies).configure()
    }
}
