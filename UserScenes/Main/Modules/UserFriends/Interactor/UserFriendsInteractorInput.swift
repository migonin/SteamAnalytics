//
//  UserFriendsInteractorInput.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

protocol UserFriendsInteractorInput {
    func prepareDataSource(user: User)
    func subscribeForDataSourceChanges()
    func unsubscribeForDataSourceChanges()

    func loadUserFriends()
    func provideUserFriends() -> [User]
}
