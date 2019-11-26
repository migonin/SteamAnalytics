//
//  UsersServicing.swift
//  Services
//
//  Created by Михаил Игонин on 22.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Storages
import Core

public protocol UsersServicing {
    func getUser(withID id: String, completionHandler: @escaping ServiceCompletion)
    func getUserFriends(_ user: User, completionHandler: @escaping ServiceCompletion)
}
