//
//  CSStatValue.swift
//  Storages
//
//  Created by Михаил Игонин on 23.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import CoreStore

public class CSStatValue: CoreStoreObject {
    public let date = Value.Required<Date>("date", initial: Date())
    public let value = Value.Required<Int>("value", initial: 0)

    public let owner = Relationship.ToOne<CSGameOwner>("owner")
    public let stat = Relationship.ToOne<CSStat>("stat", inverse: {$0.values})
}
