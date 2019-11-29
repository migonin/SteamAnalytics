//
//  HeaderCellModel.swift
//  UICommon
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public struct HeaderCellModel {
    public let title: String
    public let subtitle: String?
    public let imgUrl: String
    public let roundedImg: Bool

    public init(title: String,
                subtitle: String?,
                imgUrl: String,
                roundedImg: Bool) {
        self.title = title
        self.imgUrl = imgUrl
        self.roundedImg = roundedImg
        self.subtitle = subtitle
    }
}
