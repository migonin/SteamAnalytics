//
//  CompareUsersInteractorInput.swift
//  CompareUsersScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

protocol CompareUsersInteractorInput {
    func prepareDataSource(firstUser: User, secondUser: User)

    func getCommonGames()
    func getGameComparsion(_ game: Game)
}
