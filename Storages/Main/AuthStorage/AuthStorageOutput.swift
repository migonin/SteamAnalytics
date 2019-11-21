//
//  AuthStorageOutput.swift
//  Storages
//
//  Created by Михаил Игонин on 20.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public protocol AuthStorageOutput {
    func userIdHolder() -> UserIdHolder
    func getUserID() -> Int?
}
