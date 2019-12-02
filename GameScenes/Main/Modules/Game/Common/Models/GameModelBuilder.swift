//
//  GameModelBuilder.swift
//  GameScenes
//
//  Created by Михаил Игонин on 30.11.2019.
//  Copyright © 2019 YouDo. All rights reserved.
//

import Foundation
import Core
import UICommon

struct GameModelBuilder: GameModelBuilding {
    weak var output: GameViewOutput!

    func buildModels(settings: GameModelBuilderSettings) -> [GameCellModel] {
        var models: [GameCellModel] = []

        models.append(.header(
            HeaderCellModel(
                title: settings.game.name,
                subtitle: nil,
                imgUrl: settings.game.logo,
                roundedImg: false
            )
        ))

        if settings.gameHasNoStats {
            models.append(.error(
                MessageCellModel(
                    title: "У игры нет доступных стат. Посмотрите другие игры, например, CS: GO."
                )
            ))
        } else {
            for (stat, value) in settings.stats {
                models.append(.stat(
                    ListItemCellModel(
                        title: stat.displayName,
                        subtitle: String(value.value),
                        imgUrl: nil,
                        showDisclosureIndicator: false
                    )
                ))
            }
        }

        return models
    }
}
