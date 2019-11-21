//
//  URLRequestFactoring.swift
//  APIClient
//
//  Created by Михаил Игонин on 21.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public protocol URLRequestFactoring {
    func buildRequest(url: URL, query: QueryItemsRepresentable?, timeoutInterval: TimeInterval) throws -> URLRequest
}
