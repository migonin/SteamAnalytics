//
//  CompareUsersPresenterState.swift
//  CompareUsersScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

struct CompareUsersPresenterState {
    var isViewLoaded: Bool = false
    var isViewWillPresented: Bool = false
    var isViewPresented: Bool = false

    var firstUser: User!
    var secondUser: User!
    var game: Game? = nil

    var commonGames: [Game] = []
    var gameHasStats: Bool = true
    var comparisonResults: [StatComparison] = []
}
