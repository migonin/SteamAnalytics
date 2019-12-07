//
//  CompareUsersModelBuilderSettings.swift
//  CompareUsersScenes
//
//  Created by Михаил Игонин on 01.12.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

struct CompareUsersModelBuilderSettings {
    let firstUser: User
    let secondUser: User
    let hasCommonGames: Bool
    let selectedGame: Game?
    let gameHasStats: Bool
    let comparisonResults: [StatComparison]
}
