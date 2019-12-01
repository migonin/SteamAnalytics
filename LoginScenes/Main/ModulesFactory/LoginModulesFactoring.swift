//
//  LoginModulesFactoring.swift
//  LoginScenes
//
//  Created by Михаил Игонин on 30.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import UICommon

public protocol LoginModulesFactoring {
    func makeUserScreen() -> CoordinatableFactoryResult<EmptyOption, LoginModuleResult>
}
