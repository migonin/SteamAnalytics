//
//  GamesService.swift
//  Services
//
//  Created by Михаил Игонин on 24.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import APIClient
import Storages
import Core

public struct GamesService: GamesServicing {
    let urlFactory: URLFactoring
    let urlRequestFactory: URLRequestFactoring
    let gamesAPIClient: GamesAPIClienting
    let storage: GamesStorageInput & GamesStorageOutput
    let timeout: TimeInterval

    public init(urlFactory: URLFactoring,
                urlRequestFactory: URLRequestFactoring,
                gamesAPIClient: GamesAPIClienting,
                storage: GamesStorageInput & GamesStorageOutput,
                timeout: TimeInterval) {
        self.urlFactory = urlFactory
        self.urlRequestFactory = urlRequestFactory
        self.gamesAPIClient = gamesAPIClient
        self.storage = storage
        self.timeout = timeout
    }

    public func getUserGames(_ user: User, lastPlayed: Bool, completionHandler: @escaping ServiceCompletion) {
        let url: URL
        let request: URLRequest

        do {
            if lastPlayed {
                url = try urlFactory.buildURL(methodPath: .lastPlayedUserGames)
            } else {
                url = try urlFactory.buildURL(methodPath: .userGames)
            }

            request = try urlRequestFactory.buildRequest(url: url, query: UserGamesQuery(userId: user.id), timeoutInterval: timeout)
        } catch {
            completionHandler(.failure(error))
            return
        }

        gamesAPIClient.getUserGames(request: request) { (result) in
            switch result {
                case .success(let response):
                    self.storage.createOrUpdateOwnGames(response.response.games, lastPlayed: lastPlayed, for: user)

                completionHandler(.success(()))
                case .failure(let error):
                    completionHandler(.failure(error))
            }
        }
    }

    public func getGamesStats(_ game: Game, of user: User, completionHandler: @escaping ServiceCompletion) {
        let url: URL
        let request: URLRequest

        do {
            url = try self.urlFactory.buildURL(methodPath: .gameStats)
            request = try self.urlRequestFactory.buildRequest(url: url, query: GameStatsQuery(userId: user.id, gameId: game.id), timeoutInterval: timeout)
        } catch {
            completionHandler(.failure(error))
            return
        }

        let (schemaStats, schemaAchievements) = storage.getGameSchema(game)

        if schemaStats.count != 0 || schemaAchievements.count != 0 {
            gamesAPIClient.getGameStats(request: request) { (result) in
                switch result {
                case .success(let response):
                    self.storage.addGamesStats(stats: response.playerstats.stats, achievements: response.playerstats.achievements, for: game, user: user)

                    completionHandler(.success(()))
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
        } else {
            getGameSchema(game) { (result) in
                switch result {
                case .success(let (schemaStats, schemaAchievements)):

                    self.gamesAPIClient.getGameStats(request: request) { (result) in
                        switch result {
                        case .success(let response):
                            self.storage.addGamesStats(stats: response.playerstats.stats,
                                                       achievements: response.playerstats.achievements,
                                                       for: game,
                                                       schemaStats: schemaStats,
                                                       schemaAchievements: schemaAchievements,
                                                       user: user)

                            completionHandler(.success(()))
                        case .failure(let error):
                            completionHandler(.failure(error))
                        }
                    }

                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
        }
    }

    // MARK: Helpers
    private func getGameSchema(_ game: Game, completionHandler: @escaping (Result<([Stat], [Achievement]), Error>) -> Void) {
        let url: URL
        let request: URLRequest

        do {
            url = try self.urlFactory.buildURL(methodPath: .gameSchema)
            request = try self.urlRequestFactory.buildRequest(url: url, query: GameSchemaQuery(gameId: game.id), timeoutInterval: timeout)
        } catch {
            completionHandler(.failure(error))
            return
        }

        gamesAPIClient.getGameSchema(request: request) { (result) in
            switch result {
            case .success(let response):
                completionHandler(.success((response.game.availableGameStats.stats, response.game.availableGameStats.achievements)))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
