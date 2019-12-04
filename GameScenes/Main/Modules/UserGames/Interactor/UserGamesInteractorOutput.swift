//
//  UserGamesInteractorOutput.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Services

protocol UserGamesInteractorOutput: class {
    func didStartUserGamesLoading()
    func didFinishUserGamesLoading(result: Result<Void, Error>)

    func userChanged()
}
