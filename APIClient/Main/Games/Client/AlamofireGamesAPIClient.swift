//
//  GamesAPIClient.swift
//  APIClient
//
//  Created by Михаил Игонин on 24.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Alamofire

public struct AlamofireGamesAPIClient: GamesAPIClienting {
    let queue: DispatchQueue
    let decoder: DataDecoder

    public init(queue: DispatchQueue = DispatchQueue.main, decoder: DataDecoder = JSONDecoder()) {
        self.queue = queue
        self.decoder = decoder
    }

    public func getUserGames(request: URLRequest, completionHandler: @escaping (Result<UserGamesResponse, Error>) -> Void) {
        requestDecodable(request, completionHandler: completionHandler)
    }

    public func getGameSchema(request: URLRequest, completionHandler: @escaping (Result<GameSchemaResponse, Error>) -> Void) {
        requestDecodable(request, completionHandler: completionHandler)
    }

    public func getGameStats(request: URLRequest, completionHandler: @escaping (Result<GameStatsResponse, Error>) -> Void) {
        requestDecodable(request, completionHandler: completionHandler)
    }
}

extension AlamofireGamesAPIClient: Requestable { }
