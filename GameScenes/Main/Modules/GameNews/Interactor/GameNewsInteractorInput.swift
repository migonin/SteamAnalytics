//
//  GameNewsInteractorInput.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

protocol GameNewsInteractorInput {
    func prepareDataSource(game: Game)
    func subscribeForDataSourceChanges()
    func unsubscribeForDataSourceChanges()

    func loadGameNews(force: Bool)
    func provideGameNews() -> [NewsEntry]
}
