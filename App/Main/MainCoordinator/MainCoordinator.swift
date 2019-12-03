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
import UIKit

final class MainCoordinator: WindowCoordinator, Coordinatable {
    public typealias InputType = EmptyOption
    public typealias OutputType = EmptyOption

    let coordinatorFactory: CoordinatorFactoring
    let authStorage: AuthStorageOutput
    let userStorage: UsersStorageOutput

    public var output: ((EmptyOption) -> Void)?

    public init(coordinatorFactory: CoordinatorFactoring,
                authStorage: AuthStorageOutput,
                userStorage: UsersStorageOutput,
                window: UIWindow) {
        self.coordinatorFactory = coordinatorFactory
        self.authStorage = authStorage
        self.userStorage = userStorage

        super.init(window: window)
    }

    public func start(with option: EmptyOption, animated: Bool) {
        if let ownUserID = authStorage.getOwnUserID(), let ownUser = userStorage.getUser(withID: ownUserID) {
            runMainFlow(user: ownUser)
        } else {
            runLoginFlow()
        }
    }

    func runLoginFlow() {
        let (coordinator, presentable) = coordinatorFactory.makeLoginCoordinator()

        addDependency(coordinator)

        coordinator.output = { [weak self] result in
            guard let self = self else { return }

            if case let LoginCoordinatorResult.loggedIn(user) = result {
                self.runMainFlow(user: user)
            }
        }

        setChildCoordinator((coordinator, presentable))
        coordinator.start(with: .none, animated: true)
    }

    func runMainFlow(user: User) {
        let (coordinator, presentable) = coordinatorFactory.makeTabCoordinator()

        addDependency(coordinator)

        coordinator.output = { [weak self] result in
            guard let self = self else { return }

            if result == UserCoordinatorResult.loggedOut {
                self.runLoginFlow()
            }
        }

        setChildCoordinator((coordinator, presentable))
        coordinator.start(with: .ownUser(user), animated: true)
    }
}

