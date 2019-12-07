//
//  UsersComparisonServicing.swift
//  Services
//
//  Created by Михаил Игонин on 07.12.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

public protocol UsersComparisonServicing {
    func getCommonGames(of firstUser: User, and secondUser: User, completionHandler: @escaping (Result<[Game], Error>) -> Void)

    func compareGameStats(_ game: Game, of firstUser: User, and secondUser: User, completionHandler: @escaping (Result<[StatComparison], Error>) -> Void)
}
