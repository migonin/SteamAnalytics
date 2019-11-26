//
//  GameSchemaResponse.swift
//  APIClient
//
//  Created by Михаил Игонин on 24.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

// MARK: - GameSchemaResponse
public struct GameSchemaResponse: Decodable {
    public let game: GameResponse
}

// MARK: - GameResponse
public struct GameResponse: Decodable {
    public let gameName: String
    public let gameVersion: String
    public let availableGameStats: AvailableGameStats
}

// MARK: - AvailableGameStats
public struct AvailableGameStats: Decodable {
    public let stats: [Stat]
    public let achievements: [Achievement]
}
