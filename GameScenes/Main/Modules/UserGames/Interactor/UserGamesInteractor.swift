//
//  UserGamesInteractor.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Services
import Storages
import Core
import CoreStore

final class UserGamesInteractor: UserGamesInteractorInput {
    // MARK: Dependencies
    weak var output: UserGamesInteractorOutput!

    var gameService: GamesServicing!
    var gameStorage: GamesStorageOutput!

    var gameMonitor: ObjectMonitor<CSGameOwner>?

    var lastPlayed: Bool = false
    var user: User!
    var games: [Game]?

    let dataInvalidationTime: TimeInterval = 3600

    // MARK: - UserGamesInteractorInput
    func prepareDataSource(user: User, lastPlayed: Bool) {
        self.user = user
        self.lastPlayed = lastPlayed
        gameMonitor = gameStorage.monitorGames(of: user)
    }

    func subscribeForDataSourceChanges() {
        gameMonitor?.addObserver(self)
    }

    func unsubscribeForDataSourceChanges() {
        gameMonitor?.removeObserver(self)
    }

    func loadUserGames(force: Bool) {
        let date = lastPlayed ? gameStorage.userLastPlayedGamesSyncDate(user) : gameStorage.userGamesSyncDate(user)

        if let lastGamesSyncDate = date,
            Date().timeIntervalSince(lastGamesSyncDate) < dataInvalidationTime && !force {
            return
        }

        output.didStartUserGamesLoading()

        gameService.getUserGames(user, lastPlayed: lastPlayed) { [weak self] (result) in
            self?.output.didFinishUserGamesLoading(result: result)
        }
    }

    func provideUserGames() -> [Game] {
        if games == nil {
            games = gameStorage.getUserGames(user, lastPlayed: lastPlayed)
        }

        return games!
    }
}

extension UserGamesInteractor: ObjectObserver {
    public func objectMonitor(_ monitor: ObjectMonitor<CSGameOwner>, didUpdateObject object: CSGameOwner, changedPersistentKeys: Set<KeyPathString>) {
        games = gameStorage.getUserGames(user, lastPlayed: lastPlayed)
        output.userChanged()
    }
}
