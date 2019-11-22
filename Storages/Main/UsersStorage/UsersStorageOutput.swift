//
//  UsersStorageOutput.swift
//  Storages
//
//  Created by Михаил Игонин on 21.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public protocol UsersStorageOutput {
    func getUser(withID id: String) -> User?
}
