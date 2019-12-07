//
//  CompareUsersModelBuilder.swift
//  CompareUsersScenes
//
//  Created by Михаил Игонин on 30.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core
import UICommon

struct CompareUsersModelBuilder: CompareUsersModelBuilding {
    weak var output: CompareUsersViewOutput!

    func buildModels(settings: CompareUsersModelBuilderSettings) -> [CompareUsersCellModel] {
        var models: [CompareUsersCellModel] = []

        models.append(.header(
            TwoUsersCellModel(leftTitle: settings.firstUser.name,
                              leftImgUrl: settings.firstUser.avatarFull,
                              rightTitle: settings.secondUser.name,
                              rightImgUrl: settings.secondUser.avatarFull
            ))
        )

        if settings.hasCommonGames {
            let title = settings.selectedGame != nil ? L10n.CompareUsers.selectedGame : L10n.CompareUsers.chooseGame

            models.append(.chooseGame(
                ListItemCellModel(
                    title: title,
                    subtitle: settings.selectedGame?.name,
                    imgUrl: nil,
                    roundedImg: false,
                    showDisclosureIndicator: true
                )
            ))

            if settings.gameHasStats {
                for result in settings.comparisonResults {
                    models.append(.comarisonResult(
                        ComparisonCellModel(
                            title: result.stat.displayName,
                            leftValue: result.firstValue,
                            rightValue: result.secondValue
                        )
                    ))
                }
            } else {
                models.append(.noStats(MessageCellModel(title: L10n.Game.noStats)))
            }
        } else {
            models.append(.noGames(MessageCellModel(title: L10n.CompareUsers.noGames)))
        }




        return models
    }
}
