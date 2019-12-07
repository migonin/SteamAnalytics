//
//  GameModelBuilder.swift
//  GameScenes
//
//  Created by Михаил Игонин on 30.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core
import UICommon

struct GameModelBuilder: GameModelBuilding {
    weak var output: GameViewOutput!

    func buildModels(settings: GameModelBuilderSettings) -> [GameCellModel] {
        var models: [GameCellModel] = []

        let totalPlaytimeString = L10n.Game.Time.total(formatPlaytime(settings.game.totalPlaytime))
        let twoWeeksPlaytimeString = settings.game.playtimeTwoWeeks != 0 ? L10n.Game.Time.twoWeeks(formatPlaytime(settings.game.playtimeTwoWeeks)) : nil

        models.append(.header(
            HeaderCellModel(
                title: settings.game.name,
                subtitle: totalPlaytimeString,
                subsubtitle: twoWeeksPlaytimeString,
                imgUrl: settings.game.logo,
                roundedImg: false,
                fillImage: true,
                alignment: .leading
            )
        ))

        models.append(.news(
            ListItemCellModel(
                title: L10n.Game.news,
                subtitle: nil,
                imgUrl: nil,
                showDisclosureIndicator: true
            )
        ))

        if settings.gameHasNoStats {
            models.append(.error(
                MessageCellModel(
                    title: L10n.Game.noStats
                )
            ))
        } else {
            models.append(.stats(
                ListItemCellModel(
                    title: L10n.Game.stats,
                    subtitle: nil,
                    imgUrl: nil,
                    showDisclosureIndicator: true
                )
            ))

            models.append(.achievements(
                ListItemCellModel(
                    title: L10n.Game.achievements,
                    subtitle: nil,
                    imgUrl: nil,
                    showDisclosureIndicator: true
                )
            ))

        }

        return models
    }

    private func formatPlaytime(_ playtime: Int) -> String {
        if playtime > 60 {
            let hours = playtime / 60
            let minutes = playtime - hours * 60

            return L10n.Game.Time.hmformat(hours, minutes)
        } else {
            return L10n.Game.Time.mformat(playtime)
        }
    }
}
