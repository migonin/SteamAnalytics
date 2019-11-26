//
//  GameStatsResponse.swift
//  APIClient
//
//  Created by Михаил Игонин on 24.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

// MARK: - GameStatsResponse
public struct GameStatsResponse: Decodable {
    public let playerstats: PlayerStats
}

// MARK: - PlayerStats
public struct PlayerStats: Decodable {
    public let steamID, gameName: String
    public let stats: [StatValue]
    public let achievements: [AchievementValue]
}
