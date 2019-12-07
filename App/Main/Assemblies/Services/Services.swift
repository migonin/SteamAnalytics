//
//  Services.swift
//  Dependencies
//
//  Created by Михаил Игонин on 22.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Services
import APIClient

public final class Services {
    private static let apiKey = "91D10F93B51628B7F4C36989DA961363"
    private static let baseURL = "https://api.steampowered.com"

    public static let usersService: UsersServicing = {
        let urlFactory: URLFactoring = URLFactory(baseURL: baseURL)
        let urlRequestFactory: URLRequestFactoring = URLRequestFactory(apiKey: apiKey)
        let userAPIClient: UsersAPIClienting = AlamofireUsersAPIClient()

        return UsersService(urlFactory: urlFactory,
                            urlRequestFactory: urlRequestFactory,
                            userAPIClient: userAPIClient,
                            storage: Storages.usersStorage,
                            timeout: 60.0)

    }()

    public static let gamesService: GamesServicing = {
        let urlFactory: URLFactoring = URLFactory(baseURL: baseURL)
        let urlRequestFactory: URLRequestFactoring = URLRequestFactory(apiKey: apiKey)
        let gamesAPIClient: GamesAPIClienting = AlamofireGamesAPIClient()

        return GamesService(urlFactory: urlFactory,
                            urlRequestFactory: urlRequestFactory,
                            gamesAPIClient: gamesAPIClient,
                            storage: Storages.gamesStorage,
                            timeout: 60.0)

    }()

    public static let logoutService: LogoutServicing = {
        return LogoutService(usersStorage: Storages.usersStorage,
                             gamesStorage: Storages.gamesStorage,
                             authStorage: Storages.authStorage)
    }()

    public static let gameStatsSyncService: GameStatsSyncServicing = {
        return GameStatsSyncService(gameService: Services.gamesService,
                                    gameStorage: Storages.gamesStorage)
    }()

    public static let comparisonService: UsersComparisonServicing = {
        return UsersComparisonService(gamesService: Services.gamesService, gamesStorage: Storages.gamesStorage)
    }()

}
