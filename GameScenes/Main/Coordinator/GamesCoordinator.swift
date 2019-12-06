//
//  GamesCoordinator.swift
//  GameScenes
//
//  Created by Михаил Игонин on 01.12.2019.
//  Copyright © 2019 YouDo. All rights reserved.
//

import Foundation
import UICommon
import Core

public final class GamesCoordinator: NavigationCoordinator, Coordinatable {
    public var output: ((EmptyOption) -> Void)?

    public typealias InputType = GamesCoordinatorStartOption
    public typealias OutputType = EmptyOption

    let dependencies: GameScenesDependencies
    let modulesFactory: GameModulesFactoring
    let coordinatorsFactory: CoordinatorFactoring

    private var user: User!

    public init(dependencies: GameScenesDependencies,
                modulesFactory: GameModulesFactoring,
                coordinatorsFactory: CoordinatorFactoring,
                navigator: Navigating) {
        self.dependencies = dependencies
        self.modulesFactory = modulesFactory
        self.coordinatorsFactory = coordinatorsFactory

        super.init(navigator: navigator)
    }

    public func start(with option: GamesCoordinatorStartOption, animated: Bool) {
        super.start()

        switch option {
        case .allGames(let user):
            self.user = user
            goToGames(of: user, lastPlayed: false, animated: true)
        case .lastPlayedGames(let user):
            self.user = user
            goToGames(of: user, lastPlayed: true, animated: true)
        }
    }

    override public func allModulesPopped() {
        output?(.none)
    }

    private func goToGames(of user: User, lastPlayed: Bool, animated: Bool) {
        let (module, presentable) = modulesFactory.makeUserGamesScreen()

        module.output = { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .gameTapped(let game):
                self.goToGame(game, animated: true)
            case .back:
                if !lastPlayed {
                    self.popModule(animated: true)
                }
            }
        }

        if lastPlayed {
            module.start(with: .lastPlayedGames(of: user), animated: true)
        } else {
            module.start(with: .allGames(of: user), animated: true)
        }

        push(presentable, animated: true)
    }

    private func goToGame(_ game: Game, animated: Bool) {
        let (module, presentable) = modulesFactory.makeGameScreen()

        module.output = { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .goToStats:
                self.goToGameStats(game, animated: true)
            case .goToAchievements:
                self.goToGameAchievements(game, animated: true)
            case .goToNews:
                self.goToGameNews(game, animated: true)
            case .back:
                self.popModule(animated: true)
            }

        }

        module.start(with: .game(game, of: user), animated: true)
        push(presentable, animated: true)
    }

    private func goToGameStats(_ game: Game, animated: Bool) {
        let (module, presentable) = modulesFactory.makeGameStatsScreen()

        module.output = { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .back:
                self.popModule(animated: true)
            }

        }

        module.start(with: .gameStats(game, of: user), animated: true)
        push(presentable, animated: true)
    }

    private func goToGameAchievements(_ game: Game, animated: Bool) {
        let (module, presentable) = modulesFactory.makeGameAchievements()

        module.output = { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .back:
                self.popModule(animated: true)
            }

        }

        module.start(with: .gameAchievements(game, of: user), animated: true)
        push(presentable, animated: true)
    }

    private func goToGameNews(_ game: Game, animated: Bool) {
        let (module, presentable) = modulesFactory.makeGameNews()

        module.output = { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .back:
                self.popModule(animated: true)
            }

        }

        module.start(with: .news(of: game), animated: true)
        push(presentable, animated: true)
    }
}
