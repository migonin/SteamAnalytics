//
//  GameModulesFactoring.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import UICommon

public protocol GameModulesFactoring {
    func makeGameScreen() ->
        CoordinatableFactoryResult<GameModuleStartOption, GameModuleResult>

    func makeUserGamesScreen() ->
        CoordinatableFactoryResult<UserGamesModuleStartOption, UserGamesModuleResult>

//    func makeGameHistoryScreen() ->
//        CoordinatableFactoryResult<GameHistoryModuleStartOption, GameHistoryModuleResult>
}
