//
//  GameAchievementsItemsSourcing.swift
//  GameAchievementsScenes
//
//  Created by Михаил Игонин on 30.11.2019.
//  Copyright © 2019 YouDo. All rights reserved.
//

import Foundation

protocol GameAchievementsItemsSourcing {
    func numberOfSections() -> Int
    func itemsInSection(index: Int) -> Int
    func itemModelFor(indexPath: IndexPath) -> GameAchievementsCellModel
}
