//
//  CompareUsersViewOutput.swift
//  CompareUsersScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UIKit
import Core

protocol CompareUsersViewOutput: class {
    func didLoad()
    func willAppear(animated: Bool)
    func didAppear(animated: Bool)
    func willDisappear(animated: Bool)
    func didDisappear(animated: Bool)

    func didTapCell(at index: Int)
    func didSelectGame(_ game: Game?)
}
