//
//  Storages.swift
//  Dependencies
//
//  Created by Михаил Игонин on 20.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Storages

public final class Storages {
    public static let authStorage: AuthStorageInput & AuthStorageOutput = {
        return AuthStorage(userDefaults: UserDefaults.standard)
    }()
}
