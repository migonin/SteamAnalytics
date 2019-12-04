//
//  GamesStorage.swift
//  Storages
//
//  Created by Михаил Игонин on 23.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import CoreStore
import Core

public struct GamesStorage: GamesStorageInput, GamesStorageOutput {
    private let dataStack: DataStack

    public init(dataStack: DataStack) {
        self.dataStack = dataStack
    }

    // MARK: GamesStorageInput

    public func createOrUpdateOwnGames(_ games: [Game], lastPlayed: Bool, for user: User) {
        dataStack.perform(asynchronous: { (transaction) -> Void in
            let gamesOwner: CSGameOwner

            if let owner = try? transaction.fetchOne(From<CSGameOwner>().where(\.id == user.id)) {
                gamesOwner = owner
            } else {
                gamesOwner = transaction.create(Into<CSGameOwner>())
                gamesOwner.id.value = user.id
            }

            var csGames: [CSGame] = []

            for game in games {
                guard let csGame = try transaction.importUniqueObject(Into<CSGame>(), source: game) else { continue }
                csGames.append(csGame)

                // Delete previous playtimes first
                let oldPlaytimes = csGame.playtimes.filter({$0.owner.value?.id.value == user.id})
                transaction.delete(oldPlaytimes)

                if let playTime = try transaction.importObject(Into<CSPlaytime>(), source: game) {
                    playTime.owner.value = gamesOwner
                    playTime.game.value = csGame
                }
            }

            if lastPlayed {
                gamesOwner.lastPlayedGames.value = csGames
            } else {
                gamesOwner.games.value = csGames
            }
        }, completion: { _ in })
    }

    public func addGamesStats(stats: [StatValue], achievements: [AchievementValue], for game: Game, user: User) {
        guard let csGame = csGame(for: game) else { return }
        let owner = gamesOwnerObject(for: user)

        dataStack.perform(asynchronous: { (transaction) -> Void in
            guard let csGame = transaction.fetchExisting(csGame) else { return }
            guard let owner = transaction.fetchExisting(owner) else { return }

            let schemaCSStats = csGame.stats.value
            let schemaCSAchievements = csGame.achievements.value

            try self.addGamesStats(stats: stats,
                                   achievements: achievements,
                                   for: csGame,
                                   schemaCSStats: schemaCSStats,
                                   schemaCSAchievements: schemaCSAchievements,
                                   owner: owner,
                                   in: transaction)
        }, completion: { _ in })
    }

    public func addGamesStats(stats: [StatValue], achievements: [AchievementValue], for game: Game, schemaStats: [Stat], schemaAchievements: [Achievement], user: User) {
        guard let csGame = csGame(for: game) else { return }
        let owner = gamesOwnerObject(for: user)

        dataStack.perform(asynchronous: { (transaction) -> Void in
            guard let csGame = transaction.fetchExisting(csGame) else { return }
            guard let owner = transaction.fetchExisting(owner) else { return }

            let schemaCSStats = try transaction.importUniqueObjects(Into<CSStat>(), sourceArray: schemaStats)
            let schemaCSAchievements = try transaction.importUniqueObjects(Into<CSAchievement>(), sourceArray: schemaAchievements)

            csGame.stats.value = schemaCSStats
            csGame.achievements.value = schemaCSAchievements

            try self.addGamesStats(stats: stats,
                                   achievements: achievements,
                                   for: csGame,
                                   schemaCSStats: schemaCSStats,
                                   schemaCSAchievements: schemaCSAchievements,
                                   owner: owner,
                                   in: transaction)
        }, completion: { _ in })
    }

    // MARK: GamesStorageOutput

    public func monitorGames(of user: User) -> ObjectMonitor<CSGameOwner> {
        return dataStack.monitorObject(gamesOwnerObject(for: user))
    }

    public func monitorGame(_ game: Game) -> ObjectMonitor<CSGame> {
        guard let game = csGame(for: game) else {
            fatalError("Game not found")
        }

        return dataStack.monitorObject(game)
    }

    public func getUserGames(_ user: User, lastPlayed: Bool) -> [Game] {
        let owner = gamesOwnerObject(for: user)

        if lastPlayed {
            return owner.lastPlayedGames.value.map({$0.toGame(owner: owner)})
        } else {
            return owner.games.value.map({$0.toGame(owner: owner)})
        }
    }

    public func getGameStats(_ game: Game, user: User) -> [(Stat, [StatValue])] {
        let owner = gamesOwnerObject(for: user)
        guard let game = owner.games.value.filter({$0.id.value == game.id}).first else { return [] }

        var retArray: [(Stat, [StatValue])] = []

        for stat in game.stats.value {
            let userStats = stat.values.value
                .filter({$0.owner.value?.id.value == owner.id.value})
                .sorted(by: {$0.date.value < $1.date.value})
                .map({$0.toStatValue()})
            retArray.append((stat.toStat(), userStats))
        }

        return retArray
    }

    public func getLastGameStats(_ game: Game, user: User) -> [(Stat, StatValue)] {
        return getGameStats(game, user: user).compactMap { (stat, values) -> (Stat, StatValue)? in
            if let lastValue = values.last {
                return (stat, lastValue)
            } else {
                return nil
            }
        }
    }

    public func getGameAchievements(_ game: Game, user: User) -> [Achievement] {
        guard let game = try? dataStack.fetchOne(From<CSGame>().where(\.id == game.id)) else { return [] }

        var retArray: [Achievement] = []

        for achievement in game.achievements.value {
            if achievement.values.value.filter({$0.owner.value?.id.value == user.id}).count != 0 {
                retArray.append(achievement.toAchievement())
            }
        }

        return retArray
    }

    public func getGameSchema(_ game: Game) -> ([Stat], [Achievement]) {
        guard let game = try? dataStack.fetchOne(From<CSGame>().where(\.id == game.id)) else { return ([], []) }

        return (game.stats.value.map({$0.toStat()}), game.achievements.value.map({$0.toAchievement()}))
    }

    // MARK: Helpers
    private func gamesOwnerObject(for user: User) -> CSGameOwner {
        if let owner = try? dataStack.fetchOne(From<CSGameOwner>().where(\.id == user.id)) {
            return owner
        } else {
            // Owner not exist yet, let's create it sync
            guard let owner = try? dataStack.perform(synchronous: { transaction -> CSGameOwner in
                let owner = transaction.create(Into<CSGameOwner>())
                owner.id.value = user.id

                return owner
            }) else {
                fatalError("Data stack error, gamesOwner not created")
            }

            return owner
        }
    }

    private func csGame(for game: Game) -> CSGame? {
        return try? dataStack.fetchOne(From<CSGame>().where(\.id == game.id))
    }

    private func addGamesStats(stats: [StatValue], achievements: [AchievementValue], for csGame: CSGame, schemaCSStats: [CSStat], schemaCSAchievements: [CSAchievement], owner: CSGameOwner, in transaction: BaseDataTransaction) throws {

        for stat in stats {
            guard let schemaStat = schemaCSStats.filter({$0.name.value == stat.name}).first else { return }
            guard let statValue = try transaction.importObject(Into<CSStatValue>(), source: stat) else { return }

            statValue.stat.value = schemaStat
            statValue.owner.value = owner
        }

        //let's clear previous acheivements first
        let oldAcheivements = owner.achievements.value.filter({$0.acievement.value?.game.value?.id.value == csGame.id.value})
        transaction.delete(oldAcheivements)

        for achievement in achievements {
            guard let schemaAchievement = schemaCSAchievements.filter({$0.name.value == achievement.name}).first else { return }
            guard let achievementValue = try transaction.importObject(Into<CSAchievementValue>(), source: achievement) else { return }

            achievementValue.acievement.value = schemaAchievement
            achievementValue.owner.value = owner
        }
    }
}
