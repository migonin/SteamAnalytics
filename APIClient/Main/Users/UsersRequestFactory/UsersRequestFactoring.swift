//
//  UsersRequestFactoring.swift
//  APIClient
//
//  Created by Михаил Игонин on 21.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public protocol UsersRequestFactoring {
    func getUsers(request: URLRequest, completionHandler: @escaping (Result<APIUsersResponse, Error>) -> Void)
}
