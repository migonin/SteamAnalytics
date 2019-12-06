//
//  UserFriendsInteractor.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Services
import Storages
import Core
import CoreStore

final class UserFriendsInteractor: UserFriendsInteractorInput {
    // MARK: Dependencies
    weak var output: UserFriendsInteractorOutput!

    var userService: UsersServicing!
    var userStorage: UsersStorageOutput!

    var userMonitor: ObjectMonitor<CSUser>?

    var user: User!

    let dataInvalidationTime: TimeInterval = 3600

    // MARK: - UserFriendsInteractorInput
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

    func loadUserFriends(force: Bool) {
        if let lastFriendsSyncDate = userStorage.userFriendsSyncDate(user),
            Date().timeIntervalSince(lastFriendsSyncDate) < dataInvalidationTime && !force {
            return
        }

        output.didStartUserFriendsLoading()

        userService.getUserFriends(user) { [weak self] (result) in
            self?.output.didFinishUserFriendsLoading(result: result)
        }
    }

    func provideUserFriends() -> [User] {
        return userStorage.getUserFirends(user)
    }
}

extension UserFriendsInteractor: ObjectObserver {
    public func objectMonitor(_ monitor: ObjectMonitor<CSUser>, didUpdateObject object: CSUser, changedPersistentKeys: Set<KeyPathString>) {
        output.userChanged()
    }
}
