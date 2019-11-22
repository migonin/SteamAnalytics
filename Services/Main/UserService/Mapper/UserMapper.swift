//
//  UserMapper.swift
//  Services
//
//  Created by Михаил Игонин on 22.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Storages
import APIClient

public struct UserMapper: UserMapping {
    public init() { }

    public func mapApiUserToStorageStruct(_ user: APIUser) -> Storages.UserStruct {
        return UserStruct(id: user.steamid,
                          name: user.personaname,
                          // 1 - the profile is not visible to you (Private, Friends Only, etc), 3 - the profile is "Public"
                          isProfileVisible: user.communityvisibilitystate == 3,
                          status: UserStatus(rawValue: user.personastate) ?? .offline,
                          avatar: user.avatar,
                          avatarMedium: user.avatarmedium,
                          avatarFull: user.avatarfull,
                          lastLogOff: user.lastlogoff)
    }
}
