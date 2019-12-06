//
//  GameAchievementsModelBuilder.swift
//  GameAchievementsScenes
//
//  Created by Михаил Игонин on 30.11.2019.
//  Copyright © 2019 YouDo. All rights reserved.
//

import Foundation
import Core
import UICommon

struct GameAchievementsModelBuilder: GameAchievementsModelBuilding {
    weak var output: GameAchievementsViewOutput!

    func buildModels(settings: GameAchievementsModelBuilderSettings) -> [GameAchievementsCellModel] {
        var models: [GameAchievementsCellModel] = []

        for achievement in settings.achievements {
            models.append(.achievement(
                ListItemWithDescriptionCellModel(
                    title: achievement.displayName,
                    description: achievement.description,
                    imgUrl: achievement.icon
                )
            ))
        }

        return models
    }
}
