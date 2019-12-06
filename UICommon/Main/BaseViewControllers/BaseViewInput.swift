//
//  BaseViewInput.swift
//  UICommon
//
//  Created by Михаил Игонин on 03.12.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public protocol BaseViewInput {
    func setTitle(_ title: String)

    func showError(message: String, okButtonTitle: String?, retryButtonTitle: String?)
    func showSpinner(message: String?)
    func showSpinner()
    func hideSpinner()
}
