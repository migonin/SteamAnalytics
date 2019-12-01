//
//  Spinnerable.swift
//  UICommon
//
//  Created by Михаил Игонин on 30.11.2019.
//  Copyright © 2019 YouDo. All rights reserved.
//

import Foundation
import UIKit

public protocol Spinnerable {
    var hidingView: UIView { get }
    var spinnerView: UIActivityIndicatorView { get }
    var animationDuration: TimeInterval { get }
}

extension Spinnerable where Self: UIViewController {
    public func setupSpinner() {
        hidingView.backgroundColor = UIColor.systemGray.withAlphaComponent(0.1)
        hidingView.isHidden = true
        view.addSubview(hidingView)

        hidingView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        hidingView.addSubview(spinnerView)

        spinnerView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }

    public func showSpinner() {
        spinnerView.startAnimating()
        hidingView.isHidden = false
    }

    public func hideSpinner() {
        spinnerView.stopAnimating()
        hidingView.isHidden = true
    }
}
