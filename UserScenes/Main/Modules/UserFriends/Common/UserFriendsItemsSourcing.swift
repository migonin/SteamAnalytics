//
//  UserFriendsItemsSourcing.swift
//  UserFriendsScenes
//
//  Created by Михаил Игонин on 30.11.2019.
//  Copyright © 2019 YouDo. All rights reserved.
//

import Foundation

protocol UserFriendsItemsSourcing {
    func numberOfSections() -> Int
    func itemsInSection(index: Int) -> Int
    func itemModelFor(indexPath: IndexPath) -> UserFriendsCellModel
}
