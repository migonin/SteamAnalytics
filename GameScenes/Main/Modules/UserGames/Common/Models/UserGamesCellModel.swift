//
//  UserGamesCellModel.swift
//  UserGamesScenes
//
//  Created by Михаил Игонин on 30.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import UICommon
import Core

enum UserGamesCellModel {
    case game(Game, ListItemCellModel)
    case message(MessageCellModel)
}
