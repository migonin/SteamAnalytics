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

    public let userIds: [Int]

    public init(userIds: [Int]) {
        self.userIds = userIds
    }

    public func queryItems() -> [URLQueryItem] {
        var items = [URLQueryItem]()

        let userIdsStr: String = userIds.map({String($0)}).joined(separator: ",")
        items.append(URLQueryItem(name: Attribute.ids.rawValue, value: userIdsStr))

        return items
    }
}
