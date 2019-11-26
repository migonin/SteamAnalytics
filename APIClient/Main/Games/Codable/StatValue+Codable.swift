//
//  StatValue+Codable.swift
//  APIClient
//
//  Created by Михаил Игонин on 24.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

enum StatValueCodingKeys: String, CodingKey {
    case name = "name"
    case value = "value"
}

extension StatValue: Decodable {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: StatValueCodingKeys.self)
        
        let name = try values.decode(String.self, forKey: .name)
        let value = try values.decode(Int.self, forKey: .value)

        self.init(name: name,
                  date: Date(),
                  value: value)
    }
}
