//
//  Stat+Codable.swift
//  APIClient
//
//  Created by Михаил Игонин on 24.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

enum StatCodingKeys: String, CodingKey {
    case name = "name"
    case defaultvalue = "defaultvalue"
    case displayName = "displayName"
}

extension Stat: Decodable {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: StatCodingKeys.self)
        
        let name = try values.decode(String.self, forKey: .name)
        let displayName = try values.decode(String.self, forKey: .displayName)

        self.init(name: name,
                  displayName: displayName)
    }
}
