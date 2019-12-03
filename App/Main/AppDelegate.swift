//
//  AppDelegate.swift
//  App
//
//  Created by Михаил Игонин on 20.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UIKit
import UICommon

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private lazy var applicationCoordinator: AnyCoordinatable = self.makeMainCoordinator()

    lazy var rootNavigationController: UINavigationController = {
        let navigationController = UINavigationController()

        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()

        return navigationController
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        window = UIWindow(frame: UIScreen.main.bounds)
        applicationCoordinator.start(with: .none, animated: false)

        return true
    }

    func makeMainCoordinator() -> AnyCoordinatable<EmptyOption, EmptyOption> {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()

        self.window = window

        let coordinator = MainCoordinator(coordinatorFactory: CoordinatorFactory(),
                                          authStorage: Storages.authStorage,
                                          userStorage: Storages.usersStorage,
                                          window: window)

        return AnyCoordinatable(coordinator)
    }
}

