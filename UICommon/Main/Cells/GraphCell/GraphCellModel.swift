//
//  TwoUsersCellModel.swift
//  UICommon
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import UIKit

public struct GraphCellModel {
    public let title: String
    public let id: String
    public let values: [(Date, Int)]
    public let transformHandler: ((String, CGAffineTransform) -> Void)?

    public init(title: String,
                id: String,
                values: [(Date, Int)],
                transformHandler: ((String, CGAffineTransform) -> Void)?) {
        self.title = title
        self.id = id
        self.values = values
        self.transformHandler = transformHandler
    }
}
