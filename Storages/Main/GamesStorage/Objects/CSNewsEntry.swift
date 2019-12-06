//
//  CSNewsEntry.swift
//  Storages
//
//  Created by Михаил Игонин on 06.12.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import CoreStore

public class CSNewsEntry: CoreStoreObject {
    public let gid = Value.Required<String>("gid", initial: "")
    public let title = Value.Required<String>("title", initial: "")
    public let text = Value.Required<String>("text", initial: "")
    public let author = Value.Required<String>("author", initial: "")
    public let date = Value.Required<Date>("date", initial: Date())
    public let appid = Value.Required<Int>("appid", initial: 0)

    public let game = Relationship.ToOne<CSGame>("game")
}
