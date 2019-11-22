//
//  UsersStorage.swift
//  Storages
//
//  Created by Михаил Игонин on 21.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import CoreStore

public struct UsersStorage: UsersStorageInput, UsersStorageOutput {
    private let dataStack: DataStack

    public init(dataStack: DataStack) {
        self.dataStack = dataStack
    }

    public func getUser(withID id: String) -> User? {
        return try? dataStack.fetchOne(From<User>().where(\.id == id))
    }

    public func createOrUpdateUsers(_ users: [UserStruct]) {
        dataStack.perform(asynchronous: { (transaction) -> Void in
            _  = try transaction.importUniqueObjects(Into<User>(), sourceArray: users)
        }, completion: { _ in })
    }

    public func setFriends(_ friends: [UserStruct], to user: User) {
        dataStack.perform(asynchronous: { (transaction) -> Void in
            guard let user = transaction.fetchExisting(user) else { return }
            let friends  = try transaction.importUniqueObjects(Into<User>(), sourceArray: friends)

            user.friends.value = friends
        }, completion: { _ in })
    }

    public func deleteUser(_ user: User) {
        dataStack.perform(asynchronous: { (transaction) -> Void in
            guard let user = transaction.fetchExisting(user) else { return }

            transaction.delete(user)
        }, completion: { _ in })
    }
}
