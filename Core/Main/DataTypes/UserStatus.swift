//
//  Core.swift
//  Storages
//
//  Created by Михаил Игонин on 21.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public enum UserStatus: Int {
    case offline = 0
    case online = 1
    case busy = 2
    case away = 3
    case snooze = 4
    case lookingToTrade = 5
    case lookingToPlay = 6

    public var description: String {
        switch self {
        case .offline:
            return "Offline"
        case .online:
            return "Online"
        case .busy:
            return "Busy"
        case .away:
            return "Away"
        case .snooze:
            return "Snooze"
        case .lookingToTrade:
            return "Looking to trade"
        case .lookingToPlay:
            return "Looking to play"
        }
    }
}
