//
//  GameInteractorInput.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

protocol GameInteractorInput {
    func prepareDataSource(game: Game, of user: User)
    func subscribeForDataSourceChanges()
    func unsubscribeForDataSourceChanges()

    func provideGameStats() -> [(Stat, StatValue)]
    func loadGame()
}
