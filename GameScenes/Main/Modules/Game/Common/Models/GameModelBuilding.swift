//
//  GameModelBuilding.swift
//  GameScenes
//
//  Created by Михаил Игонин on 30.11.2019.
//  Copyright © 2019 YouDo. All rights reserved.
//

import Foundation
import Core

protocol GameModelBuilding {
    func buildModels(settings: GameModelBuilderSettings) -> [GameCellModel]
}
