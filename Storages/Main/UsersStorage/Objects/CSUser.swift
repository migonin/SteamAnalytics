//
//  CSUser.swift
//  Storages
//
//  Created by Михаил Игонин on 21.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import CoreStore

public class CSUser: CoreStoreObject {
    public let id = Value.Required<String>("id", initial: "")
    public let name = Value.Required<String>("name", initial: "")

    public let isProfileVisible = Value.Required<Bool>("isProfileVisible", initial: false)
    public let status = Value.Required<Int>("status", initial: 0)

    public let avatar = Value.Required<String>("avatar", initial: "")
    public let avatarMedium = Value.Required<String>("avatarMedium", initial: "")
    public let avatarFull = Value.Required<String>("avatarFull", initial: "")

    public let lastLogOff = Value.Required<Int>("lastLogOff", initial: 0)

    public let friends = Relationship.ToManyOrdered<CSUser>("friends", inverse: { $0.friendOf }, deleteRule: .cascade)

    //To make CoreData happy
    public let friendOf = Relationship.ToManyUnordered<CSUser>("friendOf")
}
