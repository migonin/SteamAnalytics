//
//  Navigator.swift
//  UICommon
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import UIKit


public class Navigator: NSObject {
    private(set) weak var rootController: UINavigationController!
    public weak var delegate: NavigatorDelegate?

    private var viewControllersCount = 0

    public init(rootController: UINavigationController) {
        self.rootController = rootController

        super.init()

        rootController.delegate = self
    }

}

extension Navigator: Presentable {
    public func toPresent() -> UIViewController {
        return rootController
    }
}

extension Navigator: Navigating {
    public func present(_ module: Presentable, animated: Bool) {
        rootController.present(module.toPresent(), animated: animated)
    }

    public func dismissModule(animated: Bool) {
        rootController.dismiss(animated: animated)
    }

    public func push(_ module: Presentable, animated: Bool) {
        rootController.pushViewController(module.toPresent(), animated: animated)
    }

    public func popModule(animated: Bool) {
        rootController.popViewController(animated: animated)
    }
}

extension Navigator: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        let newViewControllersCount = navigationController.viewControllers.count

        if newViewControllersCount > viewControllersCount {
            delegate?.viewControllerPushed()
        } else if newViewControllersCount < viewControllersCount {
            delegate?.viewControllerPoped()
        }

        viewControllersCount = newViewControllersCount
    }
}
