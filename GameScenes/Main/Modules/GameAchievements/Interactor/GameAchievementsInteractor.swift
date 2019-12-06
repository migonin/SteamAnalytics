//
//  GameAchievementsInteractor.swift
//  GameAchievementsScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Services
import Storages
import Core
import CoreStore

final class GameAchievementsInteractor: GameAchievementsInteractorInput {
    // MARK: Dependencies
    weak var output: GameAchievementsInteractorOutput!

    var gamesService: GamesServicing!
    var gamesStorage: GamesStorageOutput!

    var gameMonitor: ObjectMonitor<CSGame>?

    var game: Game!
    var user: User!

    // MARK: - GameAchievementsInteractorInput
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

    func provideGameAchievements() -> [Achievement] {
        return gamesStorage.getGameAchievements(game, user: user)
    }
}

extension GameAchievementsInteractor: ObjectObserver {
    public func objectMonitor(_ monitor: ObjectMonitor<CSGame>, didUpdateObject object: CSGame, changedPersistentKeys: Set<KeyPathString>) {
        output.gameChanged()
    }
}
