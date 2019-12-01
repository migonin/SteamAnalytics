//
//  UserViewInput.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

protocol UserViewInput: class {
    func setTitle(_ title: String)

    func showError(message: String, okButtonTitle: String?, retryButtonTitle: String?)
    func showSpinner()
    func hideSpinner()
    func reloadData()

    func addLogoutButton()
    func showLogoutPopup()
}
