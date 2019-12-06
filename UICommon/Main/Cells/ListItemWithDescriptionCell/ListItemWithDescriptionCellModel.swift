//
//  ListItemWithDescriptionCellModel.swift
//  UICommon
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public struct ListItemWithDescriptionCellModel {
    public let title: String
    public let imgUrl: String?
    public let description: String?

    public init(title: String,
                description: String?,
                imgUrl: String?) {
        self.title = title
        self.imgUrl = imgUrl
        self.description = description
    }
}
