//
//  AlamofireUsersRequestFactory.swift
//  APIClient
//
//  Created by Михаил Игонин on 21.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Alamofire

public struct AlamofireUsersRequestFactory: UsersRequestFactoring {
    let queue: DispatchQueue
    let decoder: DataDecoder

    public init(queue: DispatchQueue = DispatchQueue.main, decoder: DataDecoder = JSONDecoder()) {
        self.queue = queue
        self.decoder = decoder
    }

    public func getUsers(request: URLRequest, completionHandler: @escaping (Result<APIUsersResponse, Error>) -> Void) {
        requestDecodable(request, completionHandler: completionHandler)
    }
}

extension AlamofireUsersRequestFactory: Requestable { }
