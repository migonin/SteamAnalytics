//
//  GamesService.swift
//  Services
//
//  Created by Михаил Игонин on 24.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import APIClient
import Storages
import Core

public struct GamesService: GamesServicing {
    let urlFactory: URLFactoring
    let urlRequestFactory: URLRequestFactoring
    let gamesAPIClient: GamesAPIClienting
    let storage: GamesStorageInput
    let timeout: TimeInterval

    public init(urlFactory: URLFactoring,
                urlRequestFactory: URLRequestFactoring,
                gamesAPIClient: GamesAPIClienting,
                storage: GamesStorageInput,
                timeout: TimeInterval) {
        self.urlFactory = urlFactory
        self.urlRequestFactory = urlRequestFactory
        self.gamesAPIClient = gamesAPIClient
        self.storage = storage
        self.timeout = timeout
    }

    public func getUserGames(_ user: User, completionHandler: @escaping ServiceCompletion) {
        let url: URL
        let request: URLRequest

        do {
            url = try urlFactory.buildURL(methodPath: .userGames)
            request = try urlRequestFactory.buildRequest(url: url, query: UserGamesQuery(userId: user.id), timeoutInterval: timeout)
        } catch {
            completionHandler(.failure(error))
            return
        }

        gamesAPIClient.getUserGames(request: request) { (response) in
            print("")
        }
    }

    public func getGamesStats(_ game: Game, of user: User, completionHandler: @escaping ServiceCompletion) {

    }
}
