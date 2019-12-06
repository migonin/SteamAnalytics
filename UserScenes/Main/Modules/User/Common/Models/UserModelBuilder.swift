//
//  UserModelBuilder.swift
//  UserScenes
//
//  Created by Михаил Игонин on 30.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core
import UICommon

struct UserModelBuilder: UserModelBuilding {
    weak var output: UserViewOutput!

    func buildModels(settings: UserModelBuilderSettings) -> [UserCellModel] {
        var models: [UserCellModel] = []

        models.append(.header(
            HeaderCellModel(
                title: settings.user.name,
                subtitle: settings.user.status.description,
                imgUrl: settings.user.avatarFull,
                roundedImg: true
            )
        ))

        // TODO Localize
        if settings.user.isProfileVisible {
            models.append(.friends(
                ListItemCellModel(
                    title: "Друзья",
                    subtitle: nil,
                    imgUrl: nil,
                    showDisclosureIndicator: true
                )
            ))

            models.append(.games(
                ListItemCellModel(
                    title: "Игры",
                    subtitle: nil,
                    imgUrl: nil,
                    showDisclosureIndicator: true
                )
            ))
        } else {
            models.append(.privateProfile(
                MessageCellModel(
                    title: "Приватный профиль"
                )
            ))
        }


        return models
    }
}
