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

    public func getCSUser(withID id: String) -> CSUser? {
        return try? dataStack.fetchOne(From<CSUser>().where(\.id == id))
    }

    public func getUser(withID id: String) -> User? {
        return getCSUser(withID: id)?.toUser()
    }

    public func getUserFirends(_ user: User) -> [User] {
        return getCSUser(withID: user.id)?.friends.value.map({$0.toUser()}) ?? []
    }

    public func createOrUpdateUsers(_ users: [User]) {
        dataStack.perform(asynchronous: { (transaction) -> Void in
            _  = try transaction.importUniqueObjects(Into<CSUser>(), sourceArray: users)
        }, completion: { _ in })
    }

    public func setFriends(_ friends: [User], to user: User) {
        guard let csUser = getCSUser(withID: user.id) else { return }

        dataStack.perform(asynchronous: { (transaction) -> Void in
            guard let csUser = transaction.fetchExisting(csUser) else { return }
            let friends  = try transaction.importUniqueObjects(Into<CSUser>(), sourceArray: friends)

            csUser.friends.value = friends
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
