//
//  CSAchievement+Export.swift
//  Storages
//
//  Created by Михаил Игонин on 24.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

extension CSAchievement {
    public func toAchievement() -> Achievement {
        return Achievement(name: self.name.value ?? "",
                           displayName: self.displayName.value ?? "",
                           description: self.description.value ?? "",
                           icon: self.icon.value ?? "",
                           iconGray: self.iconGray.value ?? "")
    }
}
