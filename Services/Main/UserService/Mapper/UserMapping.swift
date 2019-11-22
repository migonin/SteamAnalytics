//
//  UserMapping.swift
//  Services
//
//  Created by Михаил Игонин on 22.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Storages
import APIClient

public protocol UserMapping {
    func mapApiUserToStorageStruct(_ user: APIUser) -> Storages.UserStruct
}
