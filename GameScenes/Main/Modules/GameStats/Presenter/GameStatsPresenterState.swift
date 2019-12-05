//
//  GameStatsPresenterState.swift
//  GameStatsScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

struct GameStatsPresenterState {
    var isViewLoaded: Bool = false
    var isViewWillPresented: Bool = false
    var isViewPresented: Bool = false

    var game: Game!
    var user: User!

    var gameHasNoStats = false
}
