//
//  CompareUsersModelBuilding.swift
//  CompareUsersScenes
//
//  Created by Михаил Игонин on 30.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

protocol CompareUsersModelBuilding {
    func buildModels(settings: CompareUsersModelBuilderSettings) -> [CompareUsersCellModel]
}
