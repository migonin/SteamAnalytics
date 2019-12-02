//
//  UserFriendsModelBuilder.swift
//  UserFriendsScenes
//
//  Created by Михаил Игонин on 30.11.2019.
//  Copyright © 2019 YouDo. All rights reserved.
//

import Foundation
import Core
import UICommon

struct UserFriendsModelBuilder: UserFriendsModelBuilding {
    weak var output: UserFriendsViewOutput!

    func buildModels(settings: UserFriendsModelBuilderSettings) -> [UserFriendsCellModel] {
        var models: [UserFriendsCellModel] = []

        for friend in settings.friends {
            models.append(.user(
                friend,
                ListItemCellModel(
                    title: friend.name,
                    subtitle: nil,
                    imgUrl: friend.avatarMedium,
                    showDisclosureIndicator: true
                )
            ))
        }

        return models
    }
}
