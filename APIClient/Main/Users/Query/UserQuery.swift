//
//  UsersQuery.swift
//  APIClient
//
//  Created by Михаил Игонин on 21.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public struct UserQuery: QueryItemsRepresentable {
    enum Attribute: String {
        case ids = "steamid"
    }

    public let userId: String

    public init(userId: String) {
        self.userId = userId
    }

    public func queryItems() -> [URLQueryItem] {
        var items = [URLQueryItem]()

        items.append(URLQueryItem(name: Attribute.ids.rawValue, value: userId))

        return items
    }
}
