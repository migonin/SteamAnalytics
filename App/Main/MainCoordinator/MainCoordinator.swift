//
//  MainCoordinator.swift
//  SteamAnalyticsApp
//
//  Created by Михаил Игонин on 30.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core
import Services
import Storages
import UICommon

final class MainCoordinator: BaseCoordinator, Coordinatable {
    public typealias InputType = EmptyOption
    public typealias OutputType = EmptyOption

    let coordinatorFactory: CoordinatorFactoring
    let authStorage: AuthStorageOutput
    let userStorage: UsersStorageOutput

    public var output: ((EmptyOption) -> Void)?

    public init(coordinatorFactory: CoordinatorFactoring,
                authStorage: AuthStorageOutput,
                userStorage: UsersStorageOutput,
                navigator: Navigating) {
        self.coordinatorFactory = coordinatorFactory
        self.authStorage = authStorage
        self.userStorage = userStorage

        super.init(navigator: navigator)
    }

    public func start(with option: EmptyOption, animated: Bool) {
        if let ownUserID = authStorage.getOwnUserID(), let ownUser = userStorage.getUser(withID: ownUserID) {
            runMainFlow(user: ownUser)
        } else {
            runLoginFlow()
        }
    }

    func runLoginFlow() {
        let (coordinator, _) = coordinatorFactory.makeLoginCoordinator(navigator: navigator)

        addDependency(coordinator)

        coordinator.output = { [weak self, weak coordinator] result in
            guard let self = self else { return }
            guard let coordinator = coordinator else { return }

            self.navigator.delegate = self
            self.removeDependency(coordinator)

            if case let LoginCoordinatorResult.loggedIn(user) = result {
                self.navigator.clearNavigationStack()
                self.runMainFlow(user: user)
            }
        }

        coordinator.start(with: .none, animated: true)
    }

    func runMainFlow(user: User) {
        let (coordinator, _) = coordinatorFactory.makeUserCoordinator(navigator: navigator)

        addDependency(coordinator)

        coordinator.output = { [weak self, weak coordinator] result in
            guard let self = self else { return }
            guard let coordinator = coordinator else { return }

            self.navigator.delegate = self
            self.removeDependency(coordinator)

            if result == UserCoordinatorResult.loggedOut {
                self.navigator.clearNavigationStack()
                self.runLoginFlow()
            }
        }

        coordinator.start(with: .ownUser(user), animated: true)
    }
}

