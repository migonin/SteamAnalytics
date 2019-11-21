//
//  URLExtensions.swift
//  APIClient
//
//  Created by Михаил Игонин on 21.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

extension URL {
    public func appendQueryItems(_ queryItems: [URLQueryItem]) throws -> URL {
        if queryItems.isEmpty {
            return self
        }

        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            throw URLError.cannotBeFormed
        }

        var newQueryItemsList = components.queryItems

        if newQueryItemsList == nil {
            newQueryItemsList = [URLQueryItem]()
        }

        newQueryItemsList?.append(contentsOf: queryItems)

        components.queryItems = newQueryItemsList

        guard let appendedURL = components.url else {
            throw URLError.cannotBeFormed
        }

        return appendedURL
    }
}
