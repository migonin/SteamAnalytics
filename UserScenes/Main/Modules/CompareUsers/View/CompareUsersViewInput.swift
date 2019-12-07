//
//  CompareUsersViewInput.swift
//  CompareUsersScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UICommon
import UIKit
import Core

protocol CompareUsersViewInput: class, BaseTableViewInput {
    func showGameSelector(_ games: [Game])
}
