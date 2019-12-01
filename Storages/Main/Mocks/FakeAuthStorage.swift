//
//  FakeAuthStorage.swift
//  Storages
//
//  Created by Михаил Игонин on 30.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public class FakeAuthStorage: AuthStorageInput, AuthStorageOutput {
    public func setUserID(_ userID: String?) {

    }

    public func getOwnUserID() -> String? {
        return "76561198324029511"
    }
}
