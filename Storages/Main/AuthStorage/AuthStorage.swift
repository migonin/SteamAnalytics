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

    func authUserIdHolder() -> AuthUserIdHolder {
        if let holder = try? dataStack.fetchOne(From<AuthUserIdHolder>()) {
            return holder
        } else {
            // Holder not exist yet, let's create it sync
            guard let transactionHolder = try? dataStack.perform(synchronous: { transaction -> AuthUserIdHolder in
                return transaction.create(Into<AuthUserIdHolder>())
            }) else {
                fatalError("Data stack error, userIdHolder not created")
            }

            guard let holder = dataStack.fetchExisting(transactionHolder) else {
                fatalError("Data stack error, userIdHolder not exist in main context")
            }

            return holder
        }
    }

    // MARK: AuthStorageInput
    public func setUserID(_ userID: String?) {
        let holder = authUserIdHolder()

        dataStack.perform(asynchronous: { (transaction) -> Void in
            guard let holder = transaction.fetchExisting(holder) else { return }

            holder.userId.value = userID
        }, completion: { result in
            
        })
    }

    // MARK: AuthStorageOutput
    public func getOwnUserID() -> String? {
        return authUserIdHolder().userId.value
    }
}
