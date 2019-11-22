//
//  UsersStorageInput.swift
//  Storages
//
//  Created by Михаил Игонин on 21.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public protocol UsersStorageInput {
    // Managed objects can be constructed only from unmanaged structs
    func createOrUpdateUsers(_ users: [UserStruct])
    func setFriends(_ friends: [UserStruct], to user: User)

    func deleteUser(_ user: User)
}
