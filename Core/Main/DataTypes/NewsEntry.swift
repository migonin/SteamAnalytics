//
//  NewsEntry.swift
//  Core
//
//  Created by Михаил Игонин on 06.12.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public struct NewsEntry {
    public let gid: String
    public let title: String
    public let text: String
    public let author: String
    public let date: Date
    public let appId: Int

    public init(gid: String,
                title: String,
                text: String,
                author: String,
                date: Date,
                appId: Int) {
        self.gid = gid
        self.title = title
        self.text = text
        self.author = author
        self.date = date
        self.appId = appId
    }
}
