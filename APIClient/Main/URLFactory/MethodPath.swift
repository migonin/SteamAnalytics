//
//  MethodPath.swift
//  APIClient
//
//  Created by Михаил Игонин on 21.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public enum MethodPath: String, CustomStringConvertible {
    case usersDetails = "ISteamUser/GetPlayerSummaries/v0002"
    case userFriends = "ISteamUser/GetFriendList/v0001"

    public var description: String {
        return self.rawValue
    }
}
