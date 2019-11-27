//
//  UserCoordinator.swift
//  UserScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import UICommon
import Core

public final class GameCoordinator: BaseCoordinator, Coordinatable {
    public typealias InputType = GameCoordinatorStartOption
    public typealias OutputType = Void

    let dependencies: UserScenesDependencies
    let modulesFactory: UserModulesFactoring
    let coordinatorsFactory: CoordinatorFactoring

    public init(dependencies: UserScenesDependencies,
                modulesFactory: UserModulesFactoring,
                coordinatorsFactory: CoordinatorFactoring,
                navigator: Navigating) {
        self.dependencies = dependencies
        self.modulesFactory = modulesFactory
        self.coordinatorsFactory = coordinatorsFactory

        super.init(navigator: navigator)
    }

    public func start(with option: GameCoordinatorStartOption, animated: Bool) {
        super.start()

        goToUser(nil)
    }

    public var output: ((()) -> Void)?

    private func goToUser(_ user: User?) {
        let (module, presentable) = modulesFactory.makeUserScreen()

        let startOption: UserModuleStartOption

        if let user = user {
            startOption = .otherUser(user)
        } else {
            startOption = .ownUser
        }

        module.output = { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .friendsTapped(let user):
                self.goToFriends(of: user)
            case .gamesTapped(let user):
                self.goToGames(of: user)
            case .settingsTapped:
                self.showSettings()
            }
        }

        module.start(with: startOption, animated: true)
        push(presentable, animated: true)
    }

    private func goToGames(of user: User) {

    }

    private func goToFriends(of user: User) {

    }

    private func showSettings() {

    }
}
