//
//  GameModulesFactory.swift
//  GameScenes
//
//  Created by Михаил Игонин on 01.12.2019.
//  Copyright © 2019 YouDo. All rights reserved.
//

import Foundation
import UICommon

public struct GameModulesFactory: GameModulesFactoring {
    let dependencies: GameScenesDependencies

    public init(dependencies: GameScenesDependencies) {
        self.dependencies = dependencies
    }

    public func makeGameScreen() ->
        CoordinatableFactoryResult<GameModuleStartOption, GameModuleResult> {
            return GameModuleConfigurator(dependencies: dependencies).configure()
    }

    public func makeUserGamesScreen() ->
        CoordinatableFactoryResult<UserGamesModuleStartOption, UserGamesModuleResult> {
            return UserGamesModuleConfigurator(dependencies: dependencies).configure()
    }

//    func makeGameHistoryScreen() ->
//        CoordinatableFactoryResult<GameHistoryModuleStartOption, GameHistoryModuleResult>
}
