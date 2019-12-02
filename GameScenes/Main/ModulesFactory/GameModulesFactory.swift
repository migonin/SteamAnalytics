//
//  GameModulesFactory.swift
//  GameScenes
//
//  Created by Михаил Игонин on 01.12.2019.
//  Copyright © 2019 YouDo. All rights reserved.
//

import Foundation

public struct GameModulesFactory: GameModulesFactoring {
    let dependencies: GameScenesDependencies

    public init(dependencies: GameScenesDependencies) {
        self.dependencies = dependencies
    }

    public func makeGameScreen() ->
        CoordinatableFactoryResult<GameModuleStartOption, GameModuleResult> {
            
    }

//    func makeGameHistoryScreen() ->
//        CoordinatableFactoryResult<GameHistoryModuleStartOption, GameHistoryModuleResult>
}
