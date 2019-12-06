//
//  GamesServicing.swift
//  Services
//
//  Created by Михаил Игонин on 24.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

public protocol GamesServicing {
    func getUserGames(_ user: User, lastPlayed: Bool, completionHandler: @escaping ServiceCompletion)
    func getGameStats(_ game: Game, of user: User, completionHandler: @escaping ServiceCompletion)
    func getGameNews(_ game: Game, completionHandler: @escaping ServiceCompletion)
}
