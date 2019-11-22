//
//  APIFriendsResponse.swift
//  APIClient
//
//  Created by Михаил Игонин on 22.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

// MARK: - Welcome
public struct APIFriendsResponse: Codable {
    public let friendslist: APIFriendslist
}

// MARK: - Friendslist
public struct APIFriendslist: Codable {
    public let friends: [APIFriend]
}

// MARK: - Friend
public struct APIFriend: Codable {
    public let steamid: String
}
