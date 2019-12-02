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

    var gameMonitor: ObjectMonitor<CSGame>?

    var game: Game!
    var user: User!

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

    func loadGame() {
        output.didStartGameLoading()

        gamesService.getGamesStats(game, of: user) { [weak self] (result) in
            self?.output.didFinishGameLoading(result: result)
        }
    }

    func provideGameStats() -> [(Stat, StatValue)] {
        return gamesStorage.getLastGameStats(game, user: user)
    }
}

extension GameInteractor: ObjectObserver {
    public func objectMonitor(_ monitor: ObjectMonitor<CSGame>, didUpdateObject object: CSGame, changedPersistentKeys: Set<KeyPathString>) {
        output.gameChanged()
    }
}
