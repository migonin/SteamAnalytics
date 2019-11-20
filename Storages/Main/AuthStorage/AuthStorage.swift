//
//  AuthStorage.swift
//  Storages
//
//  Created by Михаил Игонин on 20.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public final class AuthStorage: AuthStorageInput, AuthStorageOutput {
    private let userDefaults: UserDefaults

    public init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }

    public func setUserID(_ userID: Int?) {
        let key = UserDefaultsKey.authUserID.rawValue

        if let userID = userID {
            userDefaults.set(userID, forKey: key)
        } else {
            userDefaults.removeObject(forKey: key)
        }
    }

    public func getUserID() -> Int? {
        let key = UserDefaultsKey.authUserID.rawValue

        if userDefaults.object(forKey: key) != nil {
            return userDefaults.integer(forKey: key)
        } else {
            return nil
        }
    }
}
