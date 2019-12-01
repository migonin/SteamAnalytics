//
//  LoginViewController.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UIKit
import UICommon
import SnapKit

class LoginViewController: UIViewController, Spinnerable, LoginViewInput {
    public let hidingView = UIView()
    public let spinnerView = UIActivityIndicatorView(style: .whiteLarge)
    public let animationDuration = 0.3

    var output: LoginViewOutput!

    // MARK: View life cycle

    public override func loadView() {
        super.loadView()

        view.backgroundColor = UIColor.systemGray
        setupSpinner()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.didLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        output.willAppear(animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        output.didAppear(animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        output.willDisappear(animated: animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        output.didDisappear(animated: animated)
    }

    // MARK: - Alerts

    override func errorAlertOKButtonTapped() {
        output.didTapRetryButton()
    }

    override func errorAlertRetryButtonTapped() {
        output.didTapRetryButton()
    }
    
    // MARK: - LoginViewInput
    
}
