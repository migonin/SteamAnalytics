//
//  Messagable.swift
//  UICommon
//
//  Created by Михаил Игонин on 30.11.2019.
//  Copyright © 2019 YouDo. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    public func showError(message: String, okButtonTitle: String?, retryButtonTitle: String?) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)

        if let okButtonTitle = okButtonTitle {
            alertController.addAction(UIAlertAction(title: okButtonTitle, style: .default, handler: { [weak self] (_) in
                self?.errorAlertOKButtonTapped()
            }))
        }

        if let retryButtonTitle = retryButtonTitle {
            alertController.addAction(UIAlertAction(title: retryButtonTitle, style: .default, handler: { [weak self] (_) in
                self?.errorAlertRetryButtonTapped()
            }))
        }

        present(alertController, animated: true)
    }

    @objc open func errorAlertOKButtonTapped() {

    }

    @objc open func errorAlertRetryButtonTapped() {

    }
}
