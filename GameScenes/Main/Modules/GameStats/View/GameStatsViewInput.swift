//
//  GameStatsViewInput.swift
//  GameStatsScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UICommon
import UIKit

protocol GameStatsViewInput: class, BaseTableViewInput {
    func changeTransform(_ transform: CGAffineTransform, forGraphsExcept id: String)
}
