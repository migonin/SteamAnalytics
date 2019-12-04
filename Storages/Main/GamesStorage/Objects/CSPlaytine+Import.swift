//
//  CSPlaytine+Import.swift
//  Storages
//
//  Created by Михаил Игонин on 04.12.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import CoreStore
import Core

extension CSPlaytime: ImportableObject {
    public typealias ImportSource = Game

    public func didInsert(from source: Game, in transaction: BaseDataTransaction) throws {
        self.total.value = source.totalPlaytime
        self.twoWeeks.value = source.playtimeTwoWeeks
    }
}
