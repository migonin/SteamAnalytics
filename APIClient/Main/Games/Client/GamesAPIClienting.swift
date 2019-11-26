//
//  GamesAPIClienting.swift
//  APIClient
//
//  Created by Михаил Игонин on 24.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public protocol GamesAPIClienting {
    func getUserGames(request: URLRequest, completionHandler: @escaping (Result<UserGamesResponse, Error>) -> Void)
    func getGameSchema(request: URLRequest, completionHandler: @escaping (Result<GameSchemaResponse, Error>) -> Void)
    func getGameStats(request: URLRequest, completionHandler: @escaping (Result<GameStatsResponse, Error>) -> Void)
}
