//
//  NetworkingError.swift
//  APIClient
//
//  Created by Михаил Игонин on 21.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public enum NetworkingError: Error {
    case urlCannotBeFormed
    case wrongResponse
}
