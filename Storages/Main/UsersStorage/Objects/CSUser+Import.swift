//
//  CSUser+Import.swift
//  Storages
//
//  Created by Михаил Игонин on 21.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import CoreStore
import Core

extension CSUser: ImportableUniqueObject {
    public typealias UniqueIDType = String
    public typealias ImportSource = User

    public static var uniqueIDKeyPath: String {
        return "id"
    }

    public static func uniqueID(from source: User, in transaction: BaseDataTransaction) throws -> String? {
        return source.id
    }

    public func update(from source: User, in transaction: BaseDataTransaction) throws {
        self.id.value = source.id
        self.name.value = source.name
        self.isProfileVisible.value = source.isProfileVisible
        self.status.value = source.status.rawValue
        self.avatar.value = source.avatar
        self.avatarMedium.value = source.avatarMedium
        self.avatarFull.value = source.avatarFull
        self.lastLogOff.value = source.lastLogOff
    }
}
