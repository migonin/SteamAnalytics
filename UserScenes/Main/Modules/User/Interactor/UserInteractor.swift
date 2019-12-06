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
    var logoutService: LogoutServicing!
    var syncService: GameStatsSyncServicing!
    
    var userStorage: UsersStorageOutput!
    var userMonitor: ObjectMonitor<CSUser>?

    var user: User!

    let dataInvalidationTime: TimeInterval = 3600

    // MARK: - UserInteractorInput
    func prepareDataSource(user: User, startScreen: Bool) {
        self.user = user
        userMonitor = userStorage.monitorUser(user)

        if startScreen {
            syncService.syncStats(for: user)
        }
    }

    func subscribeForDataSourceChanges() {
        userMonitor?.addObserver(self)
    }

    func unsubscribeForDataSourceChanges() {
        userMonitor?.removeObserver(self)
    }

    func logout() {
        logoutService.logout()
    }

    func loadUser(force: Bool) {
        if let lastUserSyncDate = userStorage.userSyncDate(user),
            Date().timeIntervalSince(lastUserSyncDate) < dataInvalidationTime && !force {
            return
        }

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
