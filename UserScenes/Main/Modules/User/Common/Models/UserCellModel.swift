//
//  UserCellModel.swift
//  UserScenes
//
//  Created by Михаил Игонин on 30.11.2019.
//  Copyright © 2019 YouDo. All rights reserved.
//

import Foundation
import UICommon

enum UserCellModel {
    case header(HeaderCellModel)
    case privateProfile(MessageCellModel)
    case friends(ListItemCellModel)
    case games(ListItemCellModel)
}
