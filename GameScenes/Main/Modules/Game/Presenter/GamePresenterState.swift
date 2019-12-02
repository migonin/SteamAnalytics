//
//  GamePresenterState.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

struct GamePresenterState {
    var isViewLoaded: Bool = false
    var isViewWillPresented: Bool = false
    var isViewPresented: Bool = false

    var game: Game!
    var user: User!

    var gameHasNoStats = false
}
