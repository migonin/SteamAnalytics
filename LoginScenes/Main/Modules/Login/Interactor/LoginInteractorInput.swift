//
//  LoginInteractorInput.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Core

protocol LoginInteractorInput {
    func loadUserWithID(_ id: String)
    func provideUserWithID(_ id: String) -> User?
}
