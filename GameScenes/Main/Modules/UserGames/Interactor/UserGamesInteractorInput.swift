//
//  UserGamesInteractorInput.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

protocol UserGamesInteractorInput {
    func prepareDataSource(user: User, lastPlayed: Bool)
    func subscribeForDataSourceChanges()
    func unsubscribeForDataSourceChanges()

    func loadUserGames(force: Bool)
    func provideUserGames() -> [Game]
}
