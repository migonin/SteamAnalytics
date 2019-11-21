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
    let response: APIUsers
}

// MARK: - APIUsers
public struct APIUsers: Codable {
    let players: [APIUser]
}

// MARK: - APIUser
public struct APIUser: Codable {
    let steamid: String
    let communityvisibilitystate, profilestate: Int
    let personaname: String
    let lastlogoff: Int
    let profileurl: String
    let avatar, avatarmedium, avatarfull: String
    let personastate: Int
    let primaryclanid: String
    let timecreated, personastateflags: Int
}
