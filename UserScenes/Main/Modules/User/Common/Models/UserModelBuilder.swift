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

        if settings.user.isProfileVisible {
            models.append(.friends(
                ListItemCellModel(
                    title: L10n.User.friends,
                    subtitle: nil,
                    imgUrl: nil,
                    showDisclosureIndicator: true
                )
            ))

            models.append(.games(
                ListItemCellModel(
                    title: L10n.User.games,
                    subtitle: nil,
                    imgUrl: nil,
                    showDisclosureIndicator: true
                )
            ))

            if !settings.isOwn {
                models.append(.compare(
                    ListItemCellModel(
                        title: L10n.User.compare,
                        subtitle: nil,
                        imgUrl: nil,
                        showDisclosureIndicator: true
                    )
                ))
            }
        } else {
            models.append(.privateProfile(
                MessageCellModel(
                    title: L10n.User.private
                )
            ))
        }


        return models
    }
}
