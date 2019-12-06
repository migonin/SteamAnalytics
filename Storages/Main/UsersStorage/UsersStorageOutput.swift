//
//  UsersStorageOutput.swift
//  Storages
//
//  Created by Михаил Игонин on 21.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core
import CoreStore

public protocol UsersStorageOutput {
    func monitorUser(_ user: User) -> ObjectMonitor<CSUser>

    func getUser(withID id: String) -> User?
    func userSyncDate(_ user: User) -> Date?
    func userFriendsSyncDate(_ user: User) -> Date?

    func getUserFirends(_ user: User) -> [User]
}
