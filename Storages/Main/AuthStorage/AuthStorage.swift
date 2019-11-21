//
//  AuthStorage.swift
//  Storages
//
//  Created by Михаил Игонин on 20.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import CoreStore

public final class AuthStorage: AuthStorageInput, AuthStorageOutput {
    private let dataStack: DataStack

    public init(dataStack: DataStack) {
        self.dataStack = dataStack
    }

    // MARK: AuthStorageInput
    public func setUserID(_ userID: Int?) {
        let holder = userIdHolder()

        dataStack.perform(asynchronous: { (transaction) -> Void in
            guard let holder = transaction.fetchExisting(holder) else { return }

            holder.userId.value = userID
        }, completion: { result in
            
        })
    }

    // MARK: AuthStorageOutput
    public func userIdHolder() -> UserIdHolder {
        if let holder = try? dataStack.fetchOne(From<UserIdHolder>()) {
            return holder
        } else {
            // Holder not exist yet, let's create it sync
            guard let transactionHolder = try? dataStack.perform(synchronous: { transaction -> UserIdHolder in
                return transaction.create(Into<UserIdHolder>())
            }) else {
                fatalError("Data stack error, userIdHolder not created")
            }

            guard let holder = dataStack.fetchExisting(transactionHolder) else {
                fatalError("Data stack error, userIdHolder not exist in main context")
            }

            return holder
        }
    }

    public func getUserID() -> Int? {
        return userIdHolder().userId.value
    }
}
