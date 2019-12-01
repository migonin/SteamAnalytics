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
    func prepareDataSource(user: User)
    func subscribeForDataSourceChanges()
    func unsubscribeForDataSourceChanges()

    func loadUser()
    func isUserOwn(_ user: User) -> Bool

    func logout()
}
