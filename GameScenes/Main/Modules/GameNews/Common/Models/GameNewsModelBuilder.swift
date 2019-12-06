//
//  GameNewsModelBuilder.swift
//  GameNewsScenes
//
//  Created by Михаил Игонин on 30.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core
import UICommon

struct GameNewsModelBuilder: GameNewsModelBuilding {
    weak var output: GameNewsViewOutput!

    var htmlConverter: HtmlConverting!

    func buildModels(settings: GameNewsModelBuilderSettings) -> [GameNewsCellModel] {
        var models: [GameNewsCellModel] = []

        let formatter = DateFormatter()
        if let preferredLanguage = Locale.preferredLanguages.first {
            formatter.locale = Locale(identifier: preferredLanguage)
        }

        formatter.dateStyle = .long
        formatter.timeStyle = .none

        for newsEntry in settings.news {
            models.append(.newsEntry(
                NewsEntryCellModel(
                    title: newsEntry.title,
                    date: formatter.string(from: newsEntry.date),
                    text: htmlConverter.convert(htmlString: newsEntry.text)
                )
            ))
        }

        return models
    }
}
