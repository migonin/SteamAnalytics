//
//  LoginViewInput.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

protocol LoginViewInput: class {
    func showError(message: String, okButtonTitle: String?, retryButtonTitle: String?)
    func showSpinner()
    func hideSpinner()
}
