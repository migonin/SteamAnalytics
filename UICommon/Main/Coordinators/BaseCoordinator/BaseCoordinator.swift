//
//  BaseCoordinator.swift
//  UICommon
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

open class BaseCoordinator: NSObject, NavigatorDelegate {
    public private(set) var modulesInStack: Int = 0

    public var isModulesStackEmpty: Bool {
        return modulesInStack == 0
    }

    public var navigator: Navigating

    public init(navigator: Navigating) {
        self.navigator = navigator
    }

    public var childCoordinators: [AnyObject] = []

    open func isCanBeSwiped() -> Bool {
        return true
    }

    public func start() {
        navigator.delegate = self
    }

    public func push(_ module: Presentable, animated: Bool) {
        navigator.push(module, animated: animated)
    }

    public func popModule(animated: Bool) {
        navigator.popModule(animated: animated)
    }

    // add only unique object
    public func addDependency(_ coordinator: AnyObject) {
        for element in childCoordinators {
            if element === coordinator {
                return
            }
        }
        childCoordinators.append(coordinator)
    }

    public func popDependency() {
        removeDependency(childCoordinators.last)
    }

    public func removeDependency(_ coordinator: AnyObject?) {
        guard
            childCoordinators.isEmpty == false,
            let coordinator = coordinator
            else { return }

        for (index, element) in childCoordinators.enumerated() {
            if element === coordinator {
                childCoordinators.remove(at: index)
                break
            }
        }
    }

    public func viewControllerPushed() {
        modulesInStack += 1
    }

    public func viewControllerPoped() {
        modulesInStack -= 1
    }
}
