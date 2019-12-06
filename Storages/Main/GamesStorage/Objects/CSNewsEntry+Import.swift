//
//  CSNewsEntry+Import.swift
//  Storages
//
//  Created by Михаил Игонин on 06.12.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import CoreStore
import Core

extension CSNewsEntry: ImportableUniqueObject {
    public typealias UniqueIDType = String
    public typealias ImportSource = NewsEntry

    public static var uniqueIDKeyPath: String {
        return "gid"
    }

    public static func uniqueID(from source: NewsEntry, in transaction: BaseDataTransaction) throws -> String? {
        return source.gid
    }

    public func update(from source: NewsEntry, in transaction: BaseDataTransaction) throws {
        self.gid.value = source.gid
        self.title.value = source.title
        self.text.value = source.text
        self.date.value = source.date
        self.author.value = source.author
    }
}
