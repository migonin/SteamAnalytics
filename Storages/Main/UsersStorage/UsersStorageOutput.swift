//
//  UsersStorageOutput.swift
//  Storages
//
//  Created by Михаил Игонин on 21.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

public protocol UsersStorageOutput {
    func getCSUser(withID id: String) -> CSUser?
    func getUser(withID id: String) -> User?
    func getUserFirends(_ user: User) -> [User]
}
