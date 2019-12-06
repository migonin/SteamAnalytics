//
//  BaseViewController.swift
//  UICommon
//
//  Created by Михаил Игонин on 01.12.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import UIKit

open class BaseViewController: UIViewController {
    public let hidingView = UIView()
    public let spinnerView = UIActivityIndicatorView(style: .gray)
    public let textLabel = UILabel()
    public let animationDuration = 0.3

    open override func loadView() {
        super.loadView()

        setupSpinner()
    }

    private func setupSpinner() {
        if #available(iOS 13.0, *) {
            hidingView.backgroundColor = UIColor.systemBackground
            spinnerView.style = .large
        } else {
            hidingView.backgroundColor = UIColor.white
        }

        hidingView.isHidden = true
        view.addSubview(hidingView)

        hidingView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        hidingView.addSubview(spinnerView)

        spinnerView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }

        hidingView.addSubview(textLabel)

        textLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(50)
            make.top.equalTo(spinnerView.snp.bottom).offset(10)
        }

        textLabel.textColor = .gray
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
    }

    public func showSpinner() {
        showSpinner(message: nil)
    }

    public func showSpinner(message: String?) {
        spinnerView.startAnimating()
        textLabel.text = message
        
        hidingView.isHidden = false
    }

    public func hideSpinner() {
        spinnerView.stopAnimating()
        hidingView.isHidden = true
    }

    public func setTitle(_ title: String) {
        self.navigationItem.title = title
    }
}
