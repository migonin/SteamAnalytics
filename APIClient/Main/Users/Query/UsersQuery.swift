//
//  UsersQuery.swift
//  APIClient
//
//  Created by Михаил Игонин on 21.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public struct UsersQuery: QueryItemsRepresentable {
    enum Attribute: String {
        case ids = "steamids"
    }

    public let userIds: [String]

    public init(userIds: [String]) {
        self.userIds = userIds
    }

    public func queryItems() -> [URLQueryItem] {
        var items = [URLQueryItem]()

        items.append(URLQueryItem(name: Attribute.ids.rawValue, value: userIds.joined(separator: ",")))

        return items
    }
}
