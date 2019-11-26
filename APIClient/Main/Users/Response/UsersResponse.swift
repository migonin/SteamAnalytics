//
//  UsersResponse.swift
//  APIClient
//
//  Created by Михаил Игонин on 21.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

// MARK: - UsersResponse
public struct UsersResponse: Decodable {
    public let response: APIUsers
}

// MARK: - APIUsers
public struct APIUsers: Decodable {
    public let players: [User]
}
