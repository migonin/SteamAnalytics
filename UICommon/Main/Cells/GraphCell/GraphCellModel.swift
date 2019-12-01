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
    public let values: [(Date, Int)]

    public init(title: String, values: [(Date, Int)]) {
        self.title = title
        self.values = values
    }
}
