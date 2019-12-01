//
//  UserInteractor.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Services
import Storages
import Core
import CoreStore

final class UserInteractor: UserInteractorInput {
    // MARK: Dependencies
    weak var output: UserInteractorOutput!

    var userService: UsersServicing!
    var userStorage: UsersStorageOutput!
    var authStorage: (AuthStorageInput & AuthStorageOutput)!

    var userMonitor: ObjectMonitor<CSUser>?

    var user: User!

    // MARK: - UserInteractorInput
    func prepareDataSource(user: User) {
        self.user = user
        userMonitor = userStorage.monitorUser(user)
    }

    func subscribeForDataSourceChanges() {
        userMonitor?.addObserver(self)
    }

    func unsubscribeForDataSourceChanges() {
        userMonitor?.removeObserver(self)
    }

    func logout() {
        authStorage.setUserID(nil)
    }

    func isUserOwn(_ user: User) -> Bool {
        guard let ownUserID = authStorage.getOwnUserID() else { return false }

        return user.id == ownUserID
    }

    func loadUser() {
        output.didStartUserLoading()

        userService.getUser(withID: user.id) { [weak self] (result) in
            self?.output.didFinishUserLoading(result: result)
        }
    }}

extension UserInteractor: ObjectObserver {
    public func objectMonitor(_ monitor: ObjectMonitor<CSUser>, didUpdateObject object: CSUser, changedPersistentKeys: Set<KeyPathString>) {
        output.userChanged()
    }
}
