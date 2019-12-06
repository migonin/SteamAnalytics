//
//  NewsEntryCellModel.swift
//  UICommon
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public struct NewsEntryCellModel {
    public let title: String
    public let date: String
    public let text: NSAttributedString?

    public init(title: String,
                date: String,
                text: NSAttributedString?) {
        self.title = title
        self.date = date
        self.text = text
    }
}
