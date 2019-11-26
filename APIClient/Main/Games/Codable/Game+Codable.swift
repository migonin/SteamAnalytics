//
//  Game+Codable.swift
//  APIClient
//
//  Created by Михаил Игонин on 24.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

enum GameCodingKeys: String, CodingKey {
    case appid = "appid"
    case name = "name"
    case playtime_forever = "playtime_forever"
    case img_icon_url = "img_icon_url"
    case img_logo_url = "img_logo_url"
    case has_community_visible_stats = "has_community_visible_stats"
    case playtime_windows_forever = "playtime_windows_forever"
    case playtime_mac_forever = "playtime_mac_forever"
    case playtime_linux_forever = "playtime_linux_forever"
}

extension Game: Decodable {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: GameCodingKeys.self)
        
        let id = try values.decode(Int.self, forKey: .appid)
        let name = try values.decode(String.self, forKey: .name)
        let icon = try values.decode(String.self, forKey: .img_icon_url)
        let logo = try values.decode(String.self, forKey: .img_logo_url)

        self.init(id: id,
                  name: name,
                  icon: icon,
                  logo: logo)
    }
}
