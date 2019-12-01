//
//  ErrorType.swift
//  Services
//
//  Created by Михаил Игонин on 01.12.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public enum ErrorType {
    case message(text: String, okMessage: String, retryMessage: String)
    case networkError(text: String, okMessage: String, retryMessage: String)
}
