//
//  GameStatsQuery.swift
//  APIClient
//
//  Created by Михаил Игонин on 24.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public struct GameStatsQuery: QueryItemsRepresentable {
    enum Attribute: String {
        case userId = "steamid"
        case gameId = "appid"
    }

    public let userId: String
    public let gameId: Int

    public init(userId: String, gameId: Int) {
        self.userId = userId
        self.gameId = gameId
    }

    public func queryItems() -> [URLQueryItem] {
        var items = [URLQueryItem]()

        items.append(URLQueryItem(name: Attribute.gameId.rawValue, value: "\(gameId)"))
        items.append(URLQueryItem(name: Attribute.userId.rawValue, value: userId))

        return items
    }
}
