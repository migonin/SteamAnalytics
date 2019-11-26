//
//  GamesStorageInput.swift
//  Storages
//
//  Created by Михаил Игонин on 23.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

public protocol GamesStorageInput {
    func createOrUpdateOwnGames(_ games: [Game], for user: User)
    func addGamesStats(stats: [StatValue], achievements: [AchievementValue], for game: Game, user: User)
    func addGamesStats(stats: [StatValue], achievements: [AchievementValue], for game: Game, schemaStats: [Stat], schemaAchievements: [Achievement], user: User)
}
