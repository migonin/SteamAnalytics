//
//  AuthUserIdHolder.swift
//  Storages
//
//  Created by Михаил Игонин on 20.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import CoreStore

public class AuthUserIdHolder: CoreStoreObject {
    public let userId = Value.Optional<String>("userId")
}
