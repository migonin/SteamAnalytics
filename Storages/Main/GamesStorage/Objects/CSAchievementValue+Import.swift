//
//  CSAchievementValue+Import.swift
//  Storages
//
//  Created by Михаил Игонин on 24.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import CoreStore
import Core

extension CSAchievementValue: ImportableObject {
    public typealias ImportSource = AchievementValue

    public func didInsert(from source: AchievementValue, in transaction: BaseDataTransaction) throws {
        self.date.value = source.date
    }
}
