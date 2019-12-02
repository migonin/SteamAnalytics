//
//  UserGamesModelBuilder.swift
//  UserGamesScenes
//
//  Created by Михаил Игонин on 30.11.2019.
//  Copyright © 2019 YouDo. All rights reserved.
//

import Foundation
import Core
import UICommon

struct UserGamesModelBuilder: UserGamesModelBuilding {
    weak var output: UserGamesViewOutput!

    func buildModels(settings: UserGamesModelBuilderSettings) -> [UserGamesCellModel] {
        var models: [UserGamesCellModel] = []

        for game in settings.games {
            models.append(.game(
                game,
                ListItemCellModel(
                    title: game.name,
                    subtitle: nil,
                    imgUrl: game.icon,
                    showDisclosureIndicator: true
                )
            ))
        }

        return models
    }
}
