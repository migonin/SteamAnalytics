//
//  UserPresenterState.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

struct UserPresenterState {
    var isViewLoaded: Bool = false
    var isViewWillPresented: Bool = false
    var isViewPresented: Bool = false

    var startScreen: Bool = false
    var user: User!
    var isUserOwn: Bool = false
}
