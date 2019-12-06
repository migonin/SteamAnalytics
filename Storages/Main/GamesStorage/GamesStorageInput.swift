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
    func createOrUpdateOwnGames(_ games: [Game], lastPlayed: Bool, for user: User)
    func createOrUpdateOwnGames(_ games: [Game], lastPlayed: Bool, for user: User, completion: (() -> Void)?)

    func addGamesStats(stats: [StatValue], achievements: [AchievementValue], for game: Game, user: User)
    func addGamesStats(stats: [StatValue], achievements: [AchievementValue], for game: Game, schemaStats: [Stat], schemaAchievements: [Achievement], user: User)

    func createOrUpdateNews(_ news: [NewsEntry], for game: Game)
}
