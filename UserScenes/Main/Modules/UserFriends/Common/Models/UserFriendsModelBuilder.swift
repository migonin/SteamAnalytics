//
//  UserFriendsModelBuilder.swift
//  UserFriendsScenes
//
//  Created by Михаил Игонин on 30.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core
import UICommon

struct UserFriendsModelBuilder: UserFriendsModelBuilding {
    weak var output: UserFriendsViewOutput!

    func buildModels(settings: UserFriendsModelBuilderSettings) -> [UserFriendsCellModel] {
        var models: [UserFriendsCellModel] = []

        if settings.infoInaccessibleError {
            models.append(.message(
                MessageCellModel(title: "Игры пользователя недоступны")
            ))
        } else if settings.friends.isEmpty && !settings.requestInProgress {
            models.append(.message(
                MessageCellModel(title: "У пользователя нет друзей")
            ))
        } else {
            for friend in settings.friends {
                models.append(.user(
                    friend,
                    ListItemCellModel(
                        title: friend.name,
                        subtitle: nil,
                        imgUrl: friend.avatarMedium,
                        roundedImg: true,
                        showDisclosureIndicator: true
                    )
                ))
            }
        }

        return models
    }
}
