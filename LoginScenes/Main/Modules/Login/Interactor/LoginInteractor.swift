//
//  LoginInteractor.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Services
import Storages
import Core

final class LoginInteractor: LoginInteractorInput {
    var userService: UsersServicing!
    var userStorage: UsersStorageOutput!
    var authStorage: (AuthStorageInput & AuthStorageOutput)!

    // MARK: Dependencies
    weak var output: LoginInteractorOutput!

    // MARK: - LoginInteractorInput
    func provideUserWithID(_ id: String) -> User? {
        return userStorage.getUser(withID: id)
    }

    func loadUserWithID(_ id: String) {
        output.didStartUserLoading()

        userService.getUser(withID: id) { [weak self] (result) in
            self?.authStorage.setUserID(id)
            self?.output.didFinishUserLoading(result: result)
        }
    }
}
