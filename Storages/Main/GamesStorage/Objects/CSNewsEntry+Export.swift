//
//  CSNewsEntry+Export.swift
//  Storages
//
//  Created by Михаил Игонин on 06.12.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

extension CSNewsEntry {
    public func toNewsEntry() -> NewsEntry {
        return NewsEntry(gid: gid.value,
                         title: title.value,
                         text: text.value,
                         author: author.value,
                         date: date.value,
                         appId: appid.value)
    }
}
