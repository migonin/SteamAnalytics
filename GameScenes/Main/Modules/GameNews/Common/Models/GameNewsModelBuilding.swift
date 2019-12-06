//
//  GameNewsModelBuilding.swift
//  GameNewsScenes
//
//  Created by Михаил Игонин on 30.11.2019.
//  Copyright © 2019 YouDo. All rights reserved.
//

import Foundation
import Core

protocol GameNewsModelBuilding {
    func buildModels(settings: GameNewsModelBuilderSettings) -> [GameNewsCellModel]
}
