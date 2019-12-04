//
//  CSPlaytime.swift
//  Storages
//
//  Created by Михаил Игонин on 04.12.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import CoreStore

public class CSPlaytime: CoreStoreObject {
    public let total = Value.Required<Int>("total", initial: 0)
    public let twoWeeks = Value.Required<Int>("twoWeeks", initial: 0)

    public let owner = Relationship.ToOne<CSGameOwner>("owner")
    public let game = Relationship.ToOne<CSGame>("game")
}
