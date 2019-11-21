//
//  DataStackTestable.swift
//  StoragesUnitTests
//
//  Created by Михаил Игонин on 20.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import CoreStore
import XCTest

protocol DataStackTestable {
    var dataStack: DataStack! {get}
}

extension DataStackTestable where Self: XCTestCase {
    func waitForAllBackgroundOperations() {
        let waitExpectation = expectation(description: "Background operation should complete")

        dataStack.perform(asynchronous: { _  in }, completion: {_ in
            waitExpectation.fulfill()
        })

        wait(for: [waitExpectation], timeout: 1.0)
    }
}
