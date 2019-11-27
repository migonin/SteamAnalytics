//
//  GamesStorageOutput.swift
//  Storages
//
//  Created by Михаил Игонин on 23.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

public protocol GamesStorageOutput {
    func gamesOwnerObject(for user: User) -> CSGameOwner
    func csGame(for game: Game) -> CSGame?

    func getUserGames(_ user: User) -> [Game]
    func getGameSchema(_ game: Game) -> ([Stat], [Achievement])
    func getGameStats(_ game: Game, user: User) -> [(Stat, [StatValue])]
    func getGameAchievements(_ game: Game, user: User) -> [Achievement]
}
