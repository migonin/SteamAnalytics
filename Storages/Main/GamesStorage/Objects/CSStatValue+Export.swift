//
//  CSStatValue+Export.swift
//  Storages
//
//  Created by Михаил Игонин on 24.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

extension CSStatValue {
    public func toStatValue() -> StatValue {
        return StatValue(name: self.stat.value?.name.value ?? "",
                         date: self.date.value,
                         value: self.value.value)
    }
}
