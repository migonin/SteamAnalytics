//
//  User+Codable.swift
//  APIClient
//
//  Created by Михаил Игонин on 23.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

enum UserCodingKeys: String, CodingKey {
    case steamid = "steamid"
    case communityvisibilitystate = "communityvisibilitystate"
    case profilestate = "profilestate"
    case personaname = "personaname"
    case lastlogoff = "lastlogoff"
    case commentpermission = "commentpermission"
    case profileurl = "profileurl"
    case avatar = "avatar"
    case avatarmedium = "avatarmedium"
    case avatarfull = "avatarfull"
    case personastate = "personastate"
    case realname = "realname"
    case primaryclanid = "primaryclanid"
    case timecreated = "timecreated"
    case personastateflags = "personastateflags"
    case loccountrycode = "loccountrycode"
    case locstatecode = "locstatecode"
    case loccityid = "loccityid"
}

extension User: Decodable {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: UserCodingKeys.self)

        let id = try values.decode(String.self, forKey: .steamid)
        let name = try values.decode(String.self, forKey: .personaname)
        let communityVisibilityState = try values.decode(Int.self, forKey: .communityvisibilitystate)
        let status = try values.decode(Int.self, forKey: .personastate)

        let avatar = try values.decode(String.self, forKey: .avatar)
        let avatarMedium = try values.decode(String.self, forKey: .avatarmedium)
        let avatarFull = try values.decode(String.self, forKey: .avatarfull)

        let lastlogoff = try values.decode(Int.self, forKey: .lastlogoff)

        self.init(id: id,
                  name: name,
                  isProfileVisible: communityVisibilityState == 3,
                  status: UserStatus(rawValue: status) ?? .offline,
                  avatar: avatar,
                  avatarMedium: avatarMedium,
                  avatarFull: avatarFull,
                  lastLogOff: lastlogoff)
    }
}
