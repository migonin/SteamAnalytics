//
//  UserGamesItemsSourcing.swift
//  UserGamesScenes
//
//  Created by Михаил Игонин on 30.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

protocol UserGamesItemsSourcing {
    func numberOfSections() -> Int
    func itemsInSection(index: Int) -> Int
    func itemModelFor(indexPath: IndexPath) -> UserGamesCellModel
}
