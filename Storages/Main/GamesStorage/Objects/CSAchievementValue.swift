//
//  CSAchievementValue.swift
//  Storages
//
//  Created by Михаил Игонин on 23.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import CoreStore

public class CSAchievementValue: CoreStoreObject {
    public let date = Value.Required<Date>("date", initial: Date())
    
    public let owner = Relationship.ToOne<CSGameOwner>("owner")
    public let acievement = Relationship.ToOne<CSAchievement>("acievement", inverse: {$0.values})
}
