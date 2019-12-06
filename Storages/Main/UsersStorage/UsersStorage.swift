//
//  UsersStorage.swift
//  Storages
//
//  Created by Михаил Игонин on 21.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import CoreStore
import Core

public struct UsersStorage: UsersStorageInput, UsersStorageOutput {
    private let dataStack: DataStack

    public init(dataStack: DataStack) {
        self.dataStack = dataStack
    }

    func getCSUser(withID id: String) -> CSUser? {
        return try? dataStack.fetchOne(From<CSUser>().where(\.id == id))
    }

    // MARK: UserStorageOutput
    public func monitorUser(_ user: User) -> ObjectMonitor<CSUser> {
        guard let csUser = getCSUser(withID: user.id) else {
            fatalError("User not exist")
        }

        return dataStack.monitorObject(csUser)
    }

    public func getUser(withID id: String) -> User? {
        return getCSUser(withID: id)?.toUser()
    }

    public func getUserFirends(_ user: User) -> [User] {
        return getCSUser(withID: user.id)?.friends.value.map({$0.toUser()}) ?? []
    }

    public func userSyncDate(_ user: User) -> Date? {
        return getCSUser(withID: user.id)?.lastUpdateDate.value
    }

    public func userFriendsSyncDate(_ user: User) -> Date? {
        return getCSUser(withID: user.id)?.lastFriendsUpdateDate.value
    }

    public func createOrUpdateUsers(_ users: [User], completion: (() -> Void)?) {
        dataStack.perform(asynchronous: { (transaction) -> Void in
            let users  = try transaction.importUniqueObjects(Into<CSUser>(), sourceArray: users)

            users.forEach { (user) in
                user.lastUpdateDate.value = Date()
            }
        }, completion: { _ in
            completion?()
        })
    }

    public func createOrUpdateUsers(_ users: [User]) {
        createOrUpdateUsers(users, completion: nil)
    }

    public func setFriends(_ friends: [User], to user: User) {
        guard let csUser = getCSUser(withID: user.id) else { return }

        dataStack.perform(asynchronous: { (transaction) -> Void in
            guard let csUser = transaction.fetchExisting(csUser) else { return }
            let friends  = try transaction.importUniqueObjects(Into<CSUser>(), sourceArray: friends)

            csUser.friends.value = friends
            csUser.lastFriendsUpdateDate.value = Date()
        }, completion: { _ in })
    }

    public func deleteUser(_ user: User) {
        guard let csUser = getCSUser(withID: user.id) else { return }

        dataStack.perform(asynchronous: { (transaction) -> Void in
            guard let csUser = transaction.fetchExisting(csUser) else { return }

            transaction.delete(csUser)
        }, completion: { _ in })
    }
}
