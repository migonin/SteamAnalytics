//
//  UserModulesFactoring.swift
//  UserScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import UICommon

public protocol UserModulesFactoring {
    func makeUserScreen() -> CoordinatableFactoryResult<UserModuleStartOption, UserModuleResult>
//    func makeUserFriendsScreen() -> CoordinatableFactoryResult<UserScreenStartOption, Void>
//    func makeUserGamesScreen() -> CoordinatableFactoryResult<UserGamesStartOption, Void>
}
