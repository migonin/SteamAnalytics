//
//  StubCoordinator.swift
//  UICommon
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import UIKit

public final class StubCoordinator<InputType, OutputType>: Coordinatable {
    public var output: ((OutputType) -> Void)?

    public let navigator: Navigating
    public let message: String

    public init(message: String, navigator: Navigating) {
        self.navigator = navigator
        self.message = message
    }

    public func start(with option: InputType, animated: Bool) {
        let alertView = UIAlertController(title: "",
                                          message: message,
                                          preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Закрыть",
                                     style: .default,
                                     handler: nil)

        alertView.addAction(okAction)

        navigator.present(alertView, animated: true)
    }
}
