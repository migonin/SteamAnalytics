//
//  HeaderCellModel.swift
//  UICommon
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import UIKit

public struct HeaderCellModel {
    public let title: String
    public let subtitle: String?
    public let subsubtitle: String?
    public let imgUrl: String
    public let roundedImg: Bool
    public let fillImage: Bool
    public let alignment: UIStackView.Alignment

    public init(title: String,
                subtitle: String?,
                subsubtitle: String? = nil,
                imgUrl: String,
                roundedImg: Bool,
                fillImage: Bool = false,
                alignment: UIStackView.Alignment = .center) {
        self.title = title
        self.imgUrl = imgUrl
        self.roundedImg = roundedImg
        self.subtitle = subtitle
        self.subsubtitle = subsubtitle
        self.fillImage = fillImage
        self.alignment = alignment
    }
}
