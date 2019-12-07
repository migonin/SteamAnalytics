//
//  CompareUsersCellModel.swift
//  CompareUsersScenes
//
//  Created by Михаил Игонин on 30.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import UICommon

enum CompareUsersCellModel {
    case header(TwoUsersCellModel)
    case chooseGame(ListItemCellModel)
    case comarisonResult(ComparisonCellModel)
    case noStats(MessageCellModel)
    case noGames(MessageCellModel)
}
