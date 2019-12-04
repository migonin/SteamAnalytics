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

    var user: User!

    // MARK: - UserGamesInteractorInput
    func prepareDataSource(user: User) {
        self.user = user
        gameMonitor = gameStorage.monitorGames(of: user)
    }

    func subscribeForDataSourceChanges() {
        gameMonitor?.addObserver(self)
    }

    func unsubscribeForDataSourceChanges() {
        gameMonitor?.removeObserver(self)
    }

    func loadUserGames(lastPlayed: Bool) {
        output.didStartUserGamesLoading()

        gameService.getUserGames(user, lastPlayed: lastPlayed) { [weak self] (result) in
            self?.output.didFinishUserGamesLoading(result: result)
        }
    }

    func provideUserGames(lastPlayed: Bool) -> [Game] {
        return gameStorage.getUserGames(user, lastPlayed: lastPlayed)
    }
}

extension UserGamesInteractor: ObjectObserver {
    public func objectMonitor(_ monitor: ObjectMonitor<CSGameOwner>, didUpdateObject object: CSGameOwner, changedPersistentKeys: Set<KeyPathString>) {
        output.userChanged()
    }
}
