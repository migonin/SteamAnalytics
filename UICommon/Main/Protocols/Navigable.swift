//
//  Navigating.swift
//  UICommon
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import UIKit

public protocol Navigating: Presentable {
    var delegate: NavigatorDelegate? { get set }

    func present(_ module: Presentable, animated: Bool)
    func dismissModule(animated: Bool)

    func push(_ module: Presentable, animated: Bool)
    func popModule(animated: Bool)
}
