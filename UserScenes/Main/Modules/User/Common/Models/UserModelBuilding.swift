//
//  UserModelBuilding.swift
//  UserScenes
//
//  Created by Михаил Игонин on 30.11.2019.
//  Copyright © 2019 YouDo. All rights reserved.
//

import Foundation
import Core

protocol UserModelBuilding {
    func buildModels(settings: UserModelBuilderSettings) -> [UserCellModel]
}
