//
//  GameViewInput.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UICommon

protocol GameViewInput: class, BaseTableViewInput {
    func setStatsButtonHidden(_ isHidden: Bool)
}
