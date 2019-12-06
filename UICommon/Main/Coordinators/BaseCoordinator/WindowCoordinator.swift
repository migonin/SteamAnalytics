//
//  WindowCoordinator.swift
//  UICommon
//
//  Created by Михаил Игонин on 03.12.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import UIKit

open class WindowCoordinator: BaseCoordinator {
    let window: UIWindow

    public init(window: UIWindow) {
        self.window = window
    }

    public func setChildCoordinator(_ coordinator: (AnyObject, Presentable)) {
        popDependency()

        let (coordinator, presentable) = coordinator
        addDependency(coordinator)

        window.rootViewController = presentable.toPresent()
    }
}
