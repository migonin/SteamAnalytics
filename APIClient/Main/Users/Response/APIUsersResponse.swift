//
//  APIUsersResponse.swift
//  APIClient
//
//  Created by Михаил Игонин on 21.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

// MARK: - APIUsersResponse
public struct APIUsersResponse: Codable {
    public let response: APIUsers
}

// MARK: - APIUsers
public struct APIUsers: Codable {
    public let players: [APIUser]
}

// MARK: - APIUser
public struct APIUser: Codable {
    public let steamid: String
    public let communityvisibilitystate: Int
    public let personaname: String
    public let lastlogoff: Int
    public let avatar, avatarmedium, avatarfull: String
    public let personastate: Int
}
