//
//  UsersComparisonService.swift
//  Services
//
//  Created by Михаил Игонин on 07.12.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core
import Storages

public struct UsersComparisonService: UsersComparisonServicing {
    let gamesService: GamesServicing
    let gamesStorage: GamesStorageOutput

    public init(gamesService: GamesServicing, gamesStorage: GamesStorageOutput) {
        self.gamesService = gamesService
        self.gamesStorage = gamesStorage
    }

    public func getCommonGames(of firstUser: User, and secondUser: User, completionHandler: @escaping (Result<[Game], Error>) -> Void) {
        getUserGames(firstUser) { (result) in
            switch result {
            case .success(let firstUserGames):
                self.getUserGames(secondUser) { (result) in
                    switch result {
                    case .success(let secondUserGames):
                        completionHandler(.success(self.intersectGames(firstUserGames, with: secondUserGames)))
                    case .failure(let error):
                        completionHandler(.failure(error))
                    }
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

    public func compareGameStats(_ game: Game, of firstUser: User, and secondUser: User, completionHandler: @escaping (Result<[StatComparison], Error>) -> Void) {

        getUserGameStats(user: firstUser, game: game) { (result) in
            switch result {
            case .success(let firstUserStats):
                self.getUserGameStats(user: secondUser, game: game) { (result) in
                    switch result {
                    case .success(let secondUserStats):
                        self.compareStats(firstSet: firstUserStats,
                                          secondSet: secondUserStats,
                                          completionHandler: completionHandler)

                    case .failure(let error):
                        completionHandler(.failure(error))
                    }
                }

            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }


    // MARK: Helpers
    private func getUserGames(_ user: User, completionHandler: @escaping (Result<[Game], Error>) -> Void) {
        let games = gamesStorage.getUserGames(user, lastPlayed: false)

        if !games.isEmpty {
            completionHandler(.success(games))
        } else {
            gamesService.getUserGames(user, lastPlayed: false) { (result) in
                switch result {
                case .success:
                    let games = self.gamesStorage.getUserGames(user, lastPlayed: false)
                    completionHandler(.success(games))

                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
        }
    }

    private func getUserGameStats(user: User, game: Game, completionHandler: @escaping (Result<[(Stat, StatValue)], Error>) -> Void) {
        let stats = gamesStorage.getLastGameStats(game, user: user)

        if !stats.isEmpty {
            completionHandler(.success(stats))
        } else {
            gamesService.getGameStats(game, of: user) { (result) in
                switch result {
                case .success:
                    let stats = self.gamesStorage.getLastGameStats(game, user: user)
                    completionHandler(.success(stats))

                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
        }
    }

    private func intersectGames(_ games: [Game], with otherGames: [Game]) -> [Game] {
        let firstGamesSet = Set(games.map({$0.id}))
        let otherGamesSet = Set(otherGames.map({$0.id}))
        let intersection = firstGamesSet.intersection(otherGamesSet)

        return games.filter({intersection.contains($0.id)})
    }

    private func compareStats(firstSet: [(Stat, StatValue)], secondSet: [(Stat, StatValue)], completionHandler: @escaping (Result<[StatComparison], Error>) -> Void) {

        DispatchQueue.global(qos: .default).async {
            var retStats: [StatComparison] = []

            for (stat, value) in firstSet {
                if let (_, otherValue) = secondSet.first(where: {$0.0.name == stat.name}) {
                    retStats.append(StatComparison(stat: stat, firstValue: value.value, secondValue: otherValue.value))
                }
            }

            DispatchQueue.main.async {
                completionHandler(.success(retStats))
            }
        }
    }
}
