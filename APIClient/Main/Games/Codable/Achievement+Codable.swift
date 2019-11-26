//
//  Achievement+Codable.swift
//  APIClient
//
//  Created by Михаил Игонин on 24.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

enum AchievementCodingKeys: String, CodingKey {
    case name = "name"
    case defaultvalue = "defaultvalue"
    case displayName = "displayName"
    case hidden = "hidden"
    case description = "description"
    case icon = "icon"
    case icongray = "icongray"
}

extension Achievement: Decodable {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: AchievementCodingKeys.self)

        let name = try values.decode(String.self, forKey: .name)

        let displayName = try values.decode(String.self, forKey: .displayName)
        let description = try values.decode(String.self, forKey: .description)

        let icon = try values.decode(String.self, forKey: .icon)
        let iconGray = try values.decode(String.self, forKey: .icongray)

        self.init(name: name,
                  displayName: displayName,
                  description: description,
                  icon: icon,
                  iconGray: iconGray)
    }
}
