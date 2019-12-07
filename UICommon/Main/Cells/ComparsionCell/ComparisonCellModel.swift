//
//  ComparisonCellModel.swift
//  UICommon
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import UIKit

public struct ComparisonCellModel {
    public let title: String

    public let leftValue: Int
    public let rightValue: Int

    public let leftColor: UIColor
    public let rightColor: UIColor

    public init(title: String,
                leftValue: Int,
                rightValue: Int,
                leftColor: UIColor = .systemRed,
                rightColor: UIColor = .systemGreen) {
        self.title = title
        self.leftValue = leftValue
        self.rightValue = rightValue
        self.leftColor = leftColor
        self.rightColor = rightColor
    }
}
