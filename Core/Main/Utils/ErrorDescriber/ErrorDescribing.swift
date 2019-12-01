//
//  ErrorDescribing.swift
//  Services
//
//  Created by Михаил Игонин on 01.12.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public protocol ErrorDescribing {
    func describeError(_ error: Error) -> ErrorType
}
