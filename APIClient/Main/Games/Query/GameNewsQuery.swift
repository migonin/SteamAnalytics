//
//  GameQuery.swift
//  APIClient
//
//  Created by Михаил Игонин on 24.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public struct GameNewsQuery: QueryItemsRepresentable {
    enum Attribute: String {
        case gameId = "appid"
        case count = "count"
    }

    public let gameId: Int

    public init(gameId: Int) {
        self.gameId = gameId
    }

    public func queryItems() -> [URLQueryItem] {
        var items = [URLQueryItem]()

        items.append(URLQueryItem(name: Attribute.gameId.rawValue, value: "\(gameId)"))
        items.append(URLQueryItem(name: Attribute.count.rawValue, value: "5"))

        return items
    }
}
