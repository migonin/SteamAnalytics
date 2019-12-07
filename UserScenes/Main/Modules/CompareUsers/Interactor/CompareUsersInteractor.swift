//
//  CompareUsersInteractor.swift
//  CompareUsersScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Services
import Storages
import Core
import CoreStore

final class CompareUsersInteractor: CompareUsersInteractorInput {
    // MARK: Dependencies
    weak var output: CompareUsersInteractorOutput!

    var comparisonService: UsersComparisonServicing!

    var firstUser: User!
    var secondUser: User!

    // MARK: - CompareUsersInteractorInput
    func prepareDataSource(firstUser: User, secondUser: User) {
        self.firstUser = firstUser
        self.secondUser = secondUser
    }

    func getCommonGames() {
        output.didStartCommonGamesLoading()

        comparisonService.getCommonGames(of: firstUser, and: secondUser) { [weak self] (result) in
            self?.output.didFinishCommonGamesLoading(result: result)
        }
    }

    func getGameComparsion(_ game: Game) {
        output.didStartComparison()

        comparisonService.compareGameStats(game, of: firstUser, and: secondUser) { [weak self] (result) in
            self?.output.didFinishComparison(result: result)
        }
    }
}
