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

public final class UserCoordinator: NavigationCoordinator, Coordinatable {
    public typealias InputType = UserCoordinatorStartOption
    public typealias OutputType = UserCoordinatorResult

    let dependencies: UserScenesDependencies
    let modulesFactory: UserModulesFactoring
    let coordinatorsFactory: CoordinatorFactoring

    private var user: User!

    public init(dependencies: UserScenesDependencies,
                modulesFactory: UserModulesFactoring,
                coordinatorsFactory: CoordinatorFactoring,
                navigator: Navigating) {
        self.dependencies = dependencies
        self.modulesFactory = modulesFactory
        self.coordinatorsFactory = coordinatorsFactory

        super.init(navigator: navigator)
    }

    public func start(with option: UserCoordinatorStartOption, animated: Bool) {
        super.start()

        if case let UserCoordinatorStartOption.ownUser(user) = option {
            self.user = user
        }

        goToUser(user, startScreen: true,  animated: animated)
    }

    public var output: ((UserCoordinatorResult) -> Void)?

    private func goToUser(_ user: User, startScreen: Bool = false, animated: Bool) {
        let (module, presentable) = modulesFactory.makeUserScreen()

        let isOwn = self.user.id == user.id
        let startOption = startScreen ? UserModuleStartOption.startScreen(user) : UserModuleStartOption.user(user, isOwn: isOwn)

        module.output = { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .friendsTapped:
                self.goToFriends(of: user)
            case .gamesTapped:
                self.goToGames(of: user)
            case .logout:
                self.output?(.loggedOut)
            case .compareTapped:
                self.goToComparison(with: user)
            case .back:
                self.popModule(animated: true)
            }
        }

        module.start(with: startOption, animated: animated)
        push(presentable, animated: animated)
    }

    private func goToFriends(of user: User) {
        let (module, presentable) = modulesFactory.makeUserFriendsScreen()

        module.output = { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .userTapped(let user):
                self.goToUser(user, animated: true)
            case .back:
                self.popModule(animated: true)
            }

        }

        module.start(with: .user(user), animated: true)
        push(presentable, animated: true)
    }

    private func goToGames(of user: User) {
        let (coordinator, _) = coordinatorsFactory.makeGamesCoordinator(navigator: navigator)

        addDependency(coordinator)

        coordinator.output = { [weak self, weak coordinator] _ in
            guard let self = self else { return }
            guard let coordinator = coordinator else { return }

            self.navigator.delegate = self
            self.removeDependency(coordinator)
        }

        coordinator.start(with: .allGames(of: user), animated: true)
    }

    private func goToComparison(with otherUser: User) {
        let (module, presentable) = modulesFactory.makeUserComparison()

        module.output = { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .back:
                self.popModule(animated: true)
            }

        }

        module.start(with: .compare(firstUser: user, secondUser: otherUser), animated: true)
        push(presentable, animated: true)
    }
}
