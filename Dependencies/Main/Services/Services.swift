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

    public static let usersService: UsersServicing = {
        let urlFactory: URLFactoring = URLFactory(baseURL: "https://api.steampowered.com")
        let urlRequestFactory: URLRequestFactoring = URLRequestFactory(apiKey: apiKey)
        let userAPIClient: UsersAPIClienting = AlamofireUsersAPIClient()

        return UsersService(urlFactory: urlFactory,
                            urlRequestFactory: urlRequestFactory,
                            userAPIClient: userAPIClient,
                            mapper: UserMapper(),
                            storage: Storages.usersStorage,
                            timeout: 60.0)

    }()
}
