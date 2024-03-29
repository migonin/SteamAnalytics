//
//  URLRequestFactory.swift
//  APIClient
//
//  Created by Михаил Игонин on 21.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public struct URLRequestFactory: URLRequestFactoring {
    let apiKeyParameter: String
    let apiKey: String

    public init(apiKeyParameter: String = "key", apiKey: String) {
        self.apiKeyParameter = apiKeyParameter
        self.apiKey = apiKey
    }

    public func buildRequest(url: URL, query: QueryItemsRepresentable?, timeoutInterval: TimeInterval) throws -> URLRequest {
        var queredURL = url

        if let query = query {
            queredURL = try url.appendQueryItems(query.queryItems())
        }

        //Some Steam methods doesn't require api key, but let's add it to every call
        try queredURL = queredURL.appendQueryItems([URLQueryItem(name: apiKeyParameter, value: apiKey)])

        return URLRequest(url: queredURL, timeoutInterval: timeoutInterval)
    }
}
