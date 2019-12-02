//
//  BaseViewController.swift
//  UICommon
//
//  Created by Михаил Игонин on 01.12.2019.
//  Copyright © 2019 YouDo. All rights reserved.
//

import Foundation
import UIKit

open class BaseViewController: UIViewController {
    public let hidingView = UIView()
    public let spinnerView = UIActivityIndicatorView(style: .whiteLarge)
    public let animationDuration = 0.3

    open override func loadView() {
        super.loadView()

        setupSpinner()
    }

    private func setupSpinner() {
        hidingView.backgroundColor = UIColor.systemGray
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
