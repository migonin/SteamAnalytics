//
//  LoginInteractorOutput.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

protocol LoginInteractorOutput: class {
    func didStartUserLoading()
    func didFinishUserLoading(result: Result<Void, Error>)
}
