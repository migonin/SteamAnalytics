//
//  HtmlConverting.swift
//  GameScenes
//
//  Created by Михаил Игонин on 06.12.2019.
//  Copyright © 2019 YouDo. All rights reserved.
//

import Foundation

public protocol HtmlConverting {
    func convert(htmlString string: String) -> NSAttributedString?
}
