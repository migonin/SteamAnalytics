//
//  GameNewsViewOutput.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

protocol GameNewsViewOutput: class {
    func didLoad()
    func willAppear(animated: Bool)
    func didAppear(animated: Bool)
    func willDisappear(animated: Bool)
    func didDisappear(animated: Bool)

    func didTapCell(at index: Int)
    func didTapOKButton()
    func didTapRetryButton()

    func didRefresh()
}
