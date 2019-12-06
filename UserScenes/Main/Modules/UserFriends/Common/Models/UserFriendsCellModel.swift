//
//  UserFriendsCellModel.swift
//  UserFriendsScenes
//
//  Created by Михаил Игонин on 30.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import UICommon
import Core

enum UserFriendsCellModel {
    case user(User, ListItemCellModel)
    case message(MessageCellModel)
}
