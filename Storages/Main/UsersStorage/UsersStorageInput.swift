//
//  UsersStorageInput.swift
//  Storages
//
//  Created by Михаил Игонин on 21.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

public protocol UsersStorageInput {

    func createOrUpdateUsers(_ users: [User])
    func createOrUpdateUsers(_ users: [User], completion: (() -> Void)?)

    func setFriends(_ friends: [User], to user: User)

    func deleteUser(_ user: User)
}
