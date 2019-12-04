//
//  CSGame.swift
//  Storages
//
//  Created by Михаил Игонин on 23.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import CoreStore

public class CSGame: CoreStoreObject {
    public let id = Value.Required<Int>("id", initial: 0)
    public let name = Value.Required<String>("name", initial: "")
    public let iconUrl = Value.Required<String>("iconUrl", initial: "")
    public let logoUrl = Value.Required<String>("logoUrl", initial: "")

    public let achievements = Relationship.ToManyOrdered<CSAchievement>("achievements", inverse: { $0.game })
    public let stats = Relationship.ToManyOrdered<CSStat>("stats", inverse: { $0.game })

    public let owners = Relationship.ToManyUnordered<CSGameOwner>("owners")
    public let lastPlayers = Relationship.ToManyUnordered<CSGameOwner>("lastPlayers")
    public let playtimes = Relationship.ToManyUnordered<CSPlaytime>("playtimes", inverse: { $0.game })
}
