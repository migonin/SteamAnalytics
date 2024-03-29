//
//  URLFactory.swift
//  APIClient
//
//  Created by Михаил Игонин on 21.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public struct URLFactory: URLFactoring {

    public let baseURL: String

    public init(baseURL: String) {
        self.baseURL = baseURL
    }

    public func buildURL(methodPath: MethodPath) throws -> URL {
        let urlString = "\(baseURL)/\(methodPath)"

        guard let methodURL = URL(string: urlString) else {
            throw NetworkingError.urlCannotBeFormed
        }

        return methodURL
    }
}
