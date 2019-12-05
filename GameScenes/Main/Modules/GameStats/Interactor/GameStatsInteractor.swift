//
//  GameStatsInteractor.swift
//  GameStatsScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Services
import Storages
import Core
import CoreStore

final class GameStatsInteractor: GameStatsInteractorInput {
    // MARK: Dependencies
    weak var output: GameStatsInteractorOutput!

    var gamesService: GamesServicing!
    var gamesStorage: GamesStorageOutput!

    var gameMonitor: ObjectMonitor<CSGame>?

    var game: Game!
    var user: User!

    // MARK: - GameStatsInteractorInput
    func prepareDataSource(game: Game, of user: User) {
        self.user = user
        self.game = game

        gameMonitor = gamesStorage.monitorGame(game)
    }

    func subscribeForDataSourceChanges() {
        gameMonitor?.addObserver(self)
    }

    func unsubscribeForDataSourceChanges() {
        gameMonitor?.removeObserver(self)
    }

    func provideGameStats() -> [(Stat, [StatValue])]{
        return gamesStorage.getGameStats(game, user: user)
    }
}

extension GameStatsInteractor: ObjectObserver {
    public func objectMonitor(_ monitor: ObjectMonitor<CSGame>, didUpdateObject object: CSGame, changedPersistentKeys: Set<KeyPathString>) {
        output.gameChanged()
    }
}
