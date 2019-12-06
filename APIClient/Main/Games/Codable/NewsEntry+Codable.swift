//
//  NewsEntry+Codable.swift
//  APIClient
//
//  Created by Михаил Игонин on 06.12.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

enum NewsEntryCodingKeys: String, CodingKey {
    case gid = "gid"
    case title = "title"
    case url = "url"
    case is_external_url = "is_external_url"
    case author = "author"
    case contents = "contents"
    case feedlabel = "feedlabel"
    case date = "date"
    case feedname = "feedname"
    case feed_type = "feed_type"
    case appid = "appid"
}

extension NewsEntry: Decodable {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: NewsEntryCodingKeys.self)
        let gid = try values.decode(String.self, forKey: .gid)
        let title = try values.decode(String.self, forKey: .title)
        let author = try values.decode(String.self, forKey: .author)
        let contents = try values.decode(String.self, forKey: .contents)
        let date = try values.decode(Int.self, forKey: .date)
        let appid = try values.decode(Int.self, forKey: .appid)

        self.init(gid: gid,
                  title: title,
                  text: contents,
                  author: author,
                  date: Date(timeIntervalSince1970: TimeInterval(date)),
                  appId: appid)
    }
}
