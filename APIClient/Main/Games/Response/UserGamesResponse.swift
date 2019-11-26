//
//  UserGamesResponse.swift
//  APIClient
//
//  Created by Михаил Игонин on 24.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

// MARK: - UserGamesResponse
public struct UserGamesResponse: Decodable {
    public let response: GamesResponse
}

// MARK: - GamesResponse
public struct GamesResponse: Decodable {
    public let games: [Game]
}
