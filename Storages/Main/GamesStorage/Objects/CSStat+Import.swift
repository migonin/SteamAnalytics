//
//  CSStat+Import.swift
//  Storages
//
//  Created by Михаил Игонин on 24.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import CoreStore
import Core

extension CSStat: ImportableUniqueObject {
    public typealias UniqueIDType = String
    public typealias ImportSource = Stat

    public static var uniqueIDKeyPath: String {
        return "name"
    }

    public static func uniqueID(from source: Stat, in transaction: BaseDataTransaction) throws -> String? {
        return source.name
    }

    public func update(from source: Stat, in transaction: BaseDataTransaction) throws {
        self.name.value = source.name
        self.displayName.value = source.displayName
    }
}
