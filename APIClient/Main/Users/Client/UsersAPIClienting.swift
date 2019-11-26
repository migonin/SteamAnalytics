//
//  UsersAPIClienting.swift
//  APIClient
//
//  Created by Михаил Игонин on 21.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public protocol UsersAPIClienting {
    func getUsers(request: URLRequest, completionHandler: @escaping (Result<UsersResponse, Error>) -> Void)
    func getUserFriends(request: URLRequest, completionHandler: @escaping (Result<FriendsResponse, Error>) -> Void)
}
