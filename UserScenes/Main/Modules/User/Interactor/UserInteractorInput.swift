//
//  UserInteractorInput.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

protocol UserInteractorInput {
    func prepareDataSource(user: User, startScreen: Bool)
    func subscribeForDataSourceChanges()
    func unsubscribeForDataSourceChanges()

    func loadUser(force: Bool)

    func logout()
}
