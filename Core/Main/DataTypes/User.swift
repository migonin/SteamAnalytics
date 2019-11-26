//
//  User.swift
//  Core
//
//  Created by Михаил Игонин on 21.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public struct User {
    public let id: String
    public let name: String

    public let isProfileVisible: Bool
    public let status: UserStatus

    public let avatar: String
    public let avatarMedium: String
    public let avatarFull: String

    public let lastLogOff: Int

    public init(id: String,
                name: String,
                isProfileVisible: Bool,
                status: UserStatus,
                avatar: String,
                avatarMedium: String,
                avatarFull: String,
                lastLogOff: Int) {
        self.id = id
        self.name = name
        self.isProfileVisible = isProfileVisible
        self.status = status
        self.avatar = avatar
        self.avatarMedium = avatarMedium
        self.avatarFull = avatarFull
        self.lastLogOff = lastLogOff
    }
}
