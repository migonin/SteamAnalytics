//
//  GamesCoordinatorStartOption.swift
//  UICommon
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

public enum GamesCoordinatorStartOption {
    case allGames(of: User)
    case lastPlayedGames(of: User)
}
