//
//  UserViewInput.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UICommon

protocol UserViewInput: class, BaseTableViewInput {
    func addLogoutButton()
    func showLogoutPopup()
}
