//
//  GameAchievementsInteractorInput.swift
//  GameAchievementsScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

protocol GameAchievementsInteractorInput {
    func prepareDataSource(game: Game, of user: User)
    func subscribeForDataSourceChanges()
    func unsubscribeForDataSourceChanges()

    func provideGameAchievements() -> [Achievement]
}
