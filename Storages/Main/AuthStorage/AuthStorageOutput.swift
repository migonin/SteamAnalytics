//
//  AuthStorageOutput.swift
//  Storages
//
//  Created by Михаил Игонин on 20.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import CoreStore

public protocol AuthStorageOutput {
    func getOwnUserID() -> String?
}
