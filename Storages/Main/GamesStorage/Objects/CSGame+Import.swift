//
//  CSGame+Import.swift
//  Storages
//
//  Created by Михаил Игонин on 24.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import CoreStore
import Core

extension CSGame: ImportableUniqueObject {
    public typealias UniqueIDType = Int
    public typealias ImportSource = Game

    public static var uniqueIDKeyPath: String {
        return "id"
    }

    public static func uniqueID(from source: Game, in transaction: BaseDataTransaction) throws -> Int? {
        return source.id
    }

    public func update(from source: Game, in transaction: BaseDataTransaction) throws {
        self.id.value = source.id
        self.name.value = source.name
        self.iconUrl.value = source.icon
        self.logoUrl.value = source.logo
    }
}
