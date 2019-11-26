//
//  CSAchievement.swift
//  Storages
//
//  Created by Михаил Игонин on 23.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import CoreStore

public class CSAchievement: CoreStoreObject {
    public let name = Value.Required<String>("name", initial: "")
    public let displayName = Value.Required<String>("displayName", initial: "")
    public let description = Value.Required<String>("description", initial: "")
    public let icon = Value.Required<String>("icon", initial: "")
    public let iconGray = Value.Required<String>("iconGray", initial: "")

    public let game = Relationship.ToOne<CSGame>("game")
    public let values = Relationship.ToManyUnordered<CSAchievementValue>("values")
}
