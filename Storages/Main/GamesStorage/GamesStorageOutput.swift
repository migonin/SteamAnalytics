//
//  GamesStorageOutput.swift
//  Storages
//
//  Created by Михаил Игонин on 23.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core
import CoreStore

public protocol GamesStorageOutput {
    func monitorGames(of user: User) -> ObjectMonitor<CSGameOwner>
    func monitorGame(_ game: Game) -> ObjectMonitor<CSGame>

    func getUserGames(_ user: User, lastPlayed: Bool) -> [Game]
    func getGameSchema(_ game: Game) -> ([Stat], [Achievement])
    func getGameStats(_ game: Game, user: User) -> [(Stat, [StatValue])]
    func getLastGameStats(_ game: Game, user: User) -> [(Stat, StatValue)]
    func getGameAchievements(_ game: Game, user: User) -> [Achievement]

    func userGamesSyncDate(_ user: User) -> Date?
    func userLastPlayedGamesSyncDate(_ user: User) -> Date?

    func getGameNews(_ game: Game) -> [NewsEntry]
    func gameNewsSyncDate(_ game: Game) -> Date?
}
