//
//  GameCellModel.swift
//  GameScenes
//
//  Created by Михаил Игонин on 30.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import UICommon

enum GameCellModel {
    case header(HeaderCellModel)
    case error(MessageCellModel)
    case stats(ListItemCellModel)
    case achievements(ListItemCellModel)
    case news(ListItemCellModel)
}
