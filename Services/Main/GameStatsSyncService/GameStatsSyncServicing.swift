//
//  GameStatsSyncServicing.swift
//  Services
//
//  Created by Михаил Игонин on 05.12.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

public protocol GameStatsSyncServicing {
    func syncStats(for user: User)
}
