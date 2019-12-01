//
//  UserModelBuilder.swift
//  UserScenes
//
//  Created by Михаил Игонин on 30.11.2019.
//  Copyright © 2019 YouDo. All rights reserved.
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
                subtitle: nil,
                imgUrl: settings.user.avatarFull,
                roundedImg: true
            )
        ))

        // TODO Localize
        // Friends
        models.append(.friends(
            ListItemCellModel(
                title: "Friends",
                subtitle: nil,
                imgUrl: nil,
                showDisclosureIndicator: true
            )
        ))

        // Friends
        models.append(.games(
            ListItemCellModel(
                title: "Games",
                subtitle: nil,
                imgUrl: nil,
                showDisclosureIndicator: true
            )
        ))

        return models
    }
}
