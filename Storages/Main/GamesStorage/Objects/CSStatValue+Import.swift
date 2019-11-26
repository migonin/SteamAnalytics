//
//  CSStatValue+Import.swift
//  Storages
//
//  Created by Михаил Игонин on 24.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import CoreStore
import Core

extension CSStatValue: ImportableObject {
    public typealias ImportSource = StatValue

    public func didInsert(from source: StatValue, in transaction: BaseDataTransaction) throws {
        self.date.value = source.date
        self.value.value = source.value
    }
}
