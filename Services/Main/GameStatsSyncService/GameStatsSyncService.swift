//
//  GameStatsSyncService.swift
//  Services
//
//  Created by Михаил Игонин on 05.12.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core
import Storages

public class GameStatsSyncService: GameStatsSyncServicing {
    let gameService: GamesServicing
    let gameStorage: GamesStorageOutput

    var gamesToSync: [Game] = []

    var retryTime = 1.0

    public init(gameService: GamesServicing, gameStorage: GamesStorageOutput) {
        self.gameService = gameService
        self.gameStorage = gameStorage
    }

    public func syncStats(for user: User) {
        gameService.getUserGames(user, lastPlayed: false) { [weak self] (result) in
            guard let self = self else { return }

            switch result {
            case .success:
                self.updateKnownGamesStats(for: user)

            case .failure:
                Timer.scheduledTimer(withTimeInterval: self.retryTime, repeats: false) { [weak self] (_) in
                    self?.syncStats(for: user)
                }
            }
        }
    }

    private func updateKnownGamesStats(for user: User) {
        let games = gameStorage.getUserGames(user, lastPlayed: false)

        for game in games {
            if HardcodedGameId(rawValue: game.id) != nil {
                gamesToSync.append(game)
            }
        }

        syncNextGame(for: user)
    }

    private func syncNextGame(for user: User) {
        if let game = gamesToSync.first {
            gameService.getGameStats(game, of: user) { [weak self] (result) in
                guard let self = self else { return }

                switch result {
                case .success:
                    self.gamesToSync.removeFirst()
                    self.syncNextGame(for: user)

                case .failure:
                    Timer.scheduledTimer(withTimeInterval: self.retryTime, repeats: false) { [weak self] (_) in
                        self?.syncNextGame(for: user)
                    }
                }
            }
        }
    }
}
