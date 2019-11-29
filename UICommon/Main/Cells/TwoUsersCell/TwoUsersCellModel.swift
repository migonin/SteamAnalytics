//
//  TwoUsersCellModel.swift
//  UICommon
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public struct TwoUsersCellModel {
    public let leftTitle: String
    public let leftImgUrl: String

    public let rightTitle: String
    public let rightImgUrl: String

    public init(leftTitle: String,
                leftImgUrl: String,
                rightTitle: String,
                rightImgUrl: String) {
        self.leftTitle = leftTitle
        self.leftImgUrl = leftImgUrl
        self.rightTitle = rightTitle
        self.rightImgUrl = rightImgUrl
    }
}
