//
//  GameCoordinator.swift
//  GameScenes
//
//  Created by Михаил Игонин on 01.12.2019.
//  Copyright © 2019 YouDo. All rights reserved.
//

import Foundation
import UICommon
import Core

public final class GameCoordinator: NavigationCoordinator, Coordinatable {
    public var output: ((EmptyOption) -> Void)?

    public typealias InputType = GameCoordinatorStartOption
    public typealias OutputType = EmptyOption

    let dependencies: GameScenesDependencies
    let modulesFactory: GameModulesFactoring
    let coordinatorsFactory: CoordinatorFactoring

    private var game: Game!
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

    public func start(with option: GameCoordinatorStartOption, animated: Bool) {
        super.start()

        if case let GameCoordinatorStartOption.game(game, of: user) = option {
            self.game = game
            self.user = user
        }

        goToGame(game, animated: animated)
    }

    private func goToGame(_ game: Game, animated: Bool) {
        let (module, presentable) = modulesFactory.makeGameScreen()

        module.output = { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .goToStats:
                self.goToGameStats(game, animated: true)
            case .back:
                self.popModule(animated: true)
            }

        }

        module.start(with: .game(game, of: user), animated: true)
        push(presentable, animated: true)
    }

    private func goToGameStats(_ game: Game, animated: Bool) {
    }
}
