//
//  UserGamesQuery.swift
//  APIClient
//
//  Created by Михаил Игонин on 24.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public struct UserGamesQuery: QueryItemsRepresentable {
    enum Attribute: String {
        case id = "steamid"
        case includeAppInfo = "include_appinfo"
        case includeFreeGames = "include_played_free_games"
    }

    public let userId: String

    public init(userId: String) {
        self.userId = userId
    }

    public func queryItems() -> [URLQueryItem] {
        var items = [URLQueryItem]()

        items.append(URLQueryItem(name: Attribute.id.rawValue, value: userId))
        items.append(URLQueryItem(name: Attribute.includeAppInfo.rawValue, value: "1"))
        items.append(URLQueryItem(name: Attribute.includeFreeGames.rawValue, value: "1"))

        return items
    }
}
