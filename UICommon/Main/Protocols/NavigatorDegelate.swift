//
//  NavigatorDegelate.swift
//  UICommon
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public protocol NavigatorDelegate: class {
    func viewControllerPushed()
    func viewControllerPoped()
}
