//
//  UserGamesModelBuilder.swift
//  UserGamesScenes
//
//  Created by Михаил Игонин on 30.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core
import UICommon

struct UserGamesModelBuilder: UserGamesModelBuilding {
    weak var output: UserGamesViewOutput!

    func buildModels(settings: UserGamesModelBuilderSettings) -> [UserGamesCellModel] {
        var models: [UserGamesCellModel] = []

        if settings.infoInaccessibleError {
            models.append(.message(
                MessageCellModel(title: L10n.UserGames.private)
            ))
        } else if settings.games.isEmpty && !settings.requestInProgress {
            models.append(.message(
                MessageCellModel(title: L10n.UserGames.noGames)
            ))
        } else {
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
        }

        return models
    }
}
