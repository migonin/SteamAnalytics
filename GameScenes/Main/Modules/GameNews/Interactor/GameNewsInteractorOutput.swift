//
//  GameNewsInteractorOutput.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Services

protocol GameNewsInteractorOutput: class {
    func didStartGameNewsLoading()
    func didFinishGameNewsLoading(result: Result<Void, Error>)

    func gameChanged()
}
