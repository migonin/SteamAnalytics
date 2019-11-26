//
//  AchievementValue+Codable.swift
//  APIClient
//
//  Created by Михаил Игонин on 24.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

enum AchievementValueCodingKeys: String, CodingKey {
    case name = "name"
}

extension AchievementValue: Decodable {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: AchievementValueCodingKeys.self)

        let name = try values.decode(String.self, forKey: .name)

        self.init(name: name, date: Date())
    }
}
