//
//  User+Export.swift
//  Storages
//
//  Created by Михаил Игонин on 21.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

extension User {
    public func toStruct() -> UserStruct {
        return UserStruct(id: self.id.value,
                    name: self.name.value,
                    isProfileVisible: self.isProfileVisible.value,
                    status: UserStatus(rawValue: self.status.value) ?? .offline,
                    avatar: self.avatar.value,
                    avatarMedium: self.avatarMedium.value,
                    avatarFull: self.avatarFull.value,
                    lastLogOff: self.lastLogOff.value)
    }
}
