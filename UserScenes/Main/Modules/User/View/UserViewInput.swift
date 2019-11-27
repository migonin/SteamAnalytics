//
//  UserViewInput.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

protocol UserViewInput: class {
    func showError(message: String, retryButtonTitle: String?)
}
