//
//  BaseCoordinator.swift
//  UICommon
//
//  Created by Михаил Игонин on 03.12.2019.
//  Copyright © 2019 YouDo. All rights reserved.
//

import Foundation

open class BaseCoordinator: NSObject {
    public var childCoordinators: [AnyObject] = []

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
}
