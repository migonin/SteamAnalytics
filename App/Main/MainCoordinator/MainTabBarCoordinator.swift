//
//  MainTabBarCoordinator.swift
//  SteamAnalyticsApp
//
//  Created by Михаил Игонин on 03.12.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import UICommon
import Core
import UIKit

class MainTabBarCoordinator: TabBarCoordinator, Coordinatable {
    typealias InputType = UserCoordinatorStartOption
    typealias OutputType = UserCoordinatorResult

    let coordinatorFactory: CoordinatorFactoring

    var user: User!
    var output: ((UserCoordinatorResult) -> Void)?

    init(coordinatorFactory: CoordinatorFactoring, tabBarControlller: UITabBarController) {
        self.coordinatorFactory = coordinatorFactory

        super.init(tabBarController: tabBarControlller)
    }

    func start(with option: UserCoordinatorStartOption, animated: Bool) {
        if case let UserCoordinatorStartOption.ownUser(user) = option {
            self.user = user
        }

        setTabCoordinators([makeUserCoordinator()])
    }

    func makeUserCoordinator() -> CoordinatableFactoryResult<UserCoordinatorStartOption, UserCoordinatorResult> {
        let navController = UINavigationController()

        let tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
        tabBarItem.title = "Юзер"

        navController.tabBarItem = tabBarItem

        let navigator = Navigator(rootController: navController)

        let (coordinator, presentable) = coordinatorFactory.makeUserCoordinator(navigator: navigator)

        coordinator.output = { [weak self] result in
            self?.output?(result)
        }

        coordinator.start(with: .ownUser(user), animated: false)

        return (coordinator, presentable)
    }
}
