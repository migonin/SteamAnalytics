//
//  GameStatsModelBuilder.swift
//  GameStatsScenes
//
//  Created by Михаил Игонин on 30.11.2019.
//  Copyright © 2019 YouDo. All rights reserved.
//

import Foundation
import Core
import UICommon

struct GameStatsModelBuilder: GameStatsModelBuilding {
    weak var output: GameStatsViewOutput!

    func buildModels(settings: GameStatsModelBuilderSettings) -> [GameStatsCellModel] {
        var models: [GameStatsCellModel] = []

        for (stat, values) in settings.stats {
            let values = values.map({($0.date, $0.value)})

            models.append(.stat(
                GraphCellModel(
                    title: stat.displayName,
                    id: stat.name,
                    values: values,
                    transformHandler: { (id, transform) in
                        self.output.graph(withID: id, didChangeTransform: transform)
                }
            )))
        }


        return models
    }
}
