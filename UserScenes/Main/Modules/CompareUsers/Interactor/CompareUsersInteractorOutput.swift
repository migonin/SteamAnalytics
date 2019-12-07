//
//  CompareUsersInteractorOutput.swift
//  CompareUsersScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Services
import Core

protocol CompareUsersInteractorOutput: class {
    func didStartCommonGamesLoading()
    func didFinishCommonGamesLoading(result: Result<[Game], Error>)

    func didStartComparison()
    func didFinishComparison(result: Result<[StatComparison], Error>)

}
