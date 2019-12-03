//
//  LoginViewInput.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UICommon

protocol LoginViewInput: class, BaseViewInput {
    func loadRequest(_ request: URLRequest)
}
