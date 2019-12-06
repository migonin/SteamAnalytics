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

        let totalPlaytimeString = "Всего " + formatPlaytime(settings.game.totalPlaytime)
        let twoWeeksPlaytimeString = settings.game.playtimeTwoWeeks != 0 ? "За 2 недели " + formatPlaytime(settings.game.playtimeTwoWeeks) : nil

        models.append(.header(
            HeaderCellModel(
                title: settings.game.name,
                subtitle: totalPlaytimeString,
                subsubtitle: twoWeeksPlaytimeString,
                imgUrl: settings.game.logo,
                roundedImg: false,
                alignment: .leading
            )
        ))

        models.append(.news(
            ListItemCellModel(
                title: "Новости",
                subtitle: nil,
                imgUrl: nil,
                showDisclosureIndicator: true
            )
        ))

        if settings.gameHasNoStats {
            models.append(.error(
                MessageCellModel(
                    title: "У игры нет доступных стат. Посмотрите другие игры, например, CS: GO, Team Fortress 2, Portal 2, по ним есть много всего."
                )
            ))
        } else {
            models.append(.stats(
                ListItemCellModel(
                    title: "Статы",
                    subtitle: nil,
                    imgUrl: nil,
                    showDisclosureIndicator: true
                )
            ))

            models.append(.achievements(
                ListItemCellModel(
                    title: "Ачивки",
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

            return "\(hours) ч \(minutes) мин"
        } else {
            return "\(playtime) мин"
        }
    }
}
