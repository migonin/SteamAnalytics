//
//  GameStatsViewOutput.swift
//  GameStatsScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UIKit

protocol GameStatsViewOutput: class {
    func didLoad()
    func willAppear(animated: Bool)
    func didAppear(animated: Bool)
    func willDisappear(animated: Bool)
    func didDisappear(animated: Bool)

    func graph(withID id: String, didChangeTransform transform: CGAffineTransform)
}
