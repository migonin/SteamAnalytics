//
//  AuthStorageTests.swift
//  StoragesTests
//
//  Created by Михаил Игонин on 20.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import XCTest
import CoreStore
@testable import Storages

class AuthStorageTests: XCTestCase {
    var storage: AuthStorage!
    var dataStack: DataStack!

    override func setUp() {
        dataStack = DataStack(
            CoreStoreSchema(
                modelVersion: "V1",
                entities: [
                    Entity<UserIdHolder>("UserIdHolder"),
                ]
            )
        )

        try! dataStack.addStorageAndWait(
            InMemoryStore()
        )

        storage = AuthStorage(dataStack: dataStack)
    }

    func testStorageSetup_ifStorageCreated_userIdHolderShouldExistWithNilId() {
        //given

        //when

        //then
        XCTAssertNil(storage?.getUserID())
    }

    func testSetUserId_ifId_userIdHolderShouldExistWithNilId() {
        //given
        let userId = 100
        storage.setUserID(userId)

        //when
        waitForAllBackgroundOperations()

        //then
        XCTAssertEqual(storage.getUserID(), userId)
    }

}

extension AuthStorageTests: DataStackTestable { }
