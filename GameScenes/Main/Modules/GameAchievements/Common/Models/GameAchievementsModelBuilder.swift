//
//  GameAchievementsModelBuilder.swift
//  GameAchievementsScenes
//
//  Created by Михаил Игонин on 30.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
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
                TitleAndTextCellModel(
                    title: achievement.displayName,
                    description: achievement.description,
                    imgUrl: achievement.icon
                )
            ))
        }

        return models
    }
}
