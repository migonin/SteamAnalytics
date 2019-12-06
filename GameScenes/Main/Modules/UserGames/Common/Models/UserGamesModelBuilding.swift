//
//  UserGamesModelBuilding.swift
//  UserGamesScenes
//
//  Created by Михаил Игонин on 30.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

protocol UserGamesModelBuilding {
    func buildModels(settings: UserGamesModelBuilderSettings) -> [UserGamesCellModel]
}
