//
//  GameNewsResponse.swift
//  APIClient
//
//  Created by Михаил Игонин on 06.12.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

// MARK: - Welcome
public struct GameNewsResponse: Decodable {
    public let appnews: Appnews
}

// MARK: - Appnews
public struct Appnews: Decodable {
    public let appid: Int
    public let newsitems: [NewsEntry]
    public let count: Int
}
