//
//  UserGamesModuleStartOption.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Core

public enum UserGamesModuleStartOption {
    case allGames(of: User)
    case lastPlayedGames(of: User)
}
