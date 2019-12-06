//
//  GameNewsInteractor.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Services
import Storages
import Core
import CoreStore

final class GameNewsInteractor: GameNewsInteractorInput {
    // MARK: Dependencies
    weak var output: GameNewsInteractorOutput!

    var gameService: GamesServicing!
    var gameStorage: GamesStorageOutput!

    var gameMonitor: ObjectMonitor<CSGame>?

    var game: Game!
    var news: [NewsEntry]? = nil

    let dataInvalidationTime: TimeInterval = 3600

    // MARK: - GameNewsInteractorInput
    func prepareDataSource(game: Game) {
        self.game = game
        gameMonitor = gameStorage.monitorGame(game)
    }

    func subscribeForDataSourceChanges() {
        gameMonitor?.addObserver(self)
    }

    func unsubscribeForDataSourceChanges() {
        gameMonitor?.removeObserver(self)
    }

    func loadGameNews(force: Bool) {
        let date = gameStorage.gameNewsSyncDate(game)

        if let lastGamesSyncDate = date,
            Date().timeIntervalSince(lastGamesSyncDate) < dataInvalidationTime && !force {
            return
        }

        output.didStartGameNewsLoading()

        gameService.getGameNews(game) { [weak self] (result) in
            self?.output.didFinishGameNewsLoading(result: result)
        }
    }

    func provideGameNews() -> [NewsEntry] {
        if news == nil {
            news = gameStorage.getGameNews(game)
        }

        return news!
    }
}

extension GameNewsInteractor: ObjectObserver {
    public func objectMonitor(_ monitor: ObjectMonitor<CSGame>, didUpdateObject object: CSGame, changedPersistentKeys: Set<KeyPathString>) {
        news = gameStorage.getGameNews(game)
        output.gameChanged()
    }
}
