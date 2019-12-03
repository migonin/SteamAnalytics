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

open class BaseTableViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    public let tableView = UITableView()

    open override func loadView() {
        super.loadView()

        setupTableView()
        registerCells()
    }

    private func setupTableView() {
        view.insertSubview(tableView, belowSubview: hidingView)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()

        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let selectedIndex = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndex, animated: false)
        }
    }

    open func registerCells() {

    }

    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fatalError("Need to be overriden")
    }

    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError("Need to be overriden")
    }
}