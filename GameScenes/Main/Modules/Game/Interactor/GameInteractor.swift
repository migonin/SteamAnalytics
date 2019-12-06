//
//  GameInteractor.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Services
import Storages
import Core
import CoreStore

final class GameInteractor: GameInteractorInput {
    // MARK: Dependencies
    weak var output: GameInteractorOutput!

    var gamesService: GamesServicing!
    var gamesStorage: GamesStorageOutput!
    let dataInvalidationTime: TimeInterval = 3600

    var gameMonitor: ObjectMonitor<CSGame>?

    var game: Game!
    var user: User!

    var stats: [(Stat, StatValue)]? = nil

    // MARK: - GameInteractorInput
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

    func loadGame(force: Bool) {
        if let (_, firstValue) = stats?.first, Date().timeIntervalSince(firstValue.date) < dataInvalidationTime && !force {
            return
        }

        output.didStartGameLoading()

        gamesService.getGamesStats(game, of: user) { [weak self] (result) in
            self?.output.didFinishGameLoading(result: result)
        }
    }

    func provideGameStats() -> [(Stat, StatValue)] {
        if stats == nil {
            stats = gamesStorage.getLastGameStats(game, user: user)
        }

        return stats!
    }
}

extension GameInteractor: ObjectObserver {
    public func objectMonitor(_ monitor: ObjectMonitor<CSGame>, didUpdateObject object: CSGame, changedPersistentKeys: Set<KeyPathString>) {
        stats = gamesStorage.getLastGameStats(game, user: user)
        output.gameChanged()
    }
}
