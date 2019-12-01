//
//  BaseTableViewController.swift
//  UICommon
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

open class BaseTableViewController: UITableViewController, Spinnerable {
    public let hidingView = UIView()
    public let spinnerView = UIActivityIndicatorView(style: .whiteLarge)
    public let animationDuration = 0.3

    open override func loadView() {
        super.loadView()

        registerCells()
        setupSpinner()
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        // Hide empty cells
        tableView.tableFooterView = UIView()
    }

    open func registerCells() {

    }

    func setupSpinner() {

    }
}
