//
//  CSGameOwner.swift
//  Storages
//
//  Created by Михаил Игонин on 23.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import CoreStore

public class CSGameOwner: CoreStoreObject {
    public let id = Value.Required<String>("id", initial: "")

    public let games = Relationship.ToManyOrdered<CSGame>("games", inverse: { $0.owners })
    public let achievements = Relationship.ToManyUnordered<CSAchievementValue>("achievements", inverse: { $0.owner })
    public let stats = Relationship.ToManyUnordered<CSStatValue>("stats", inverse: { $0.owner })
}
