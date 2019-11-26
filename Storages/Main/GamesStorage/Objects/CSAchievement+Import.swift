//
//  CSAchievement+Import.swift
//  Storages
//
//  Created by Михаил Игонин on 24.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import CoreStore
import Core

extension CSAchievement: ImportableUniqueObject {
    public typealias UniqueIDType = String
    public typealias ImportSource = Achievement

    public static var uniqueIDKeyPath: String {
        return "name"
    }

    public static func uniqueID(from source: Achievement, in transaction: BaseDataTransaction) throws -> String? {
        return source.name
    }

    public func update(from source: Achievement, in transaction: BaseDataTransaction) throws {
        self.name.value = source.name
        self.displayName.value = source.displayName
        self.description.value = source.description
        self.icon.value = source.icon
        self.iconGray.value = source.iconGray
    }
}
