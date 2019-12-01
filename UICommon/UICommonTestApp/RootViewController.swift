//
//  RootViewController.swift
//  UICommonTestApp
//
//  Created by Михаил Игонин on 29.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UIKit
import UICommon

class RootViewController: UITableViewController {

    enum Row: String, CaseIterable {
        case headerCells = "HeaderCells"
        case listItemCells = "LitItemCells"
        case userComparsion = "UserComparsion"
        case graphCells = "GraphCells"
    }

    let dataSource = Row.allCases

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        title = "UI элементы"
        tableView.registerClassCell(UITableViewCell.self)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableTypedCell(for: indexPath, cellType: UITableViewCell.self)
        cell.textLabel?.text = dataSource[indexPath.row].rawValue
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch dataSource[indexPath.row] {
        case .headerCells:
            navigationController?.pushViewController(HeaderCellsViewController(), animated: true)
        case .listItemCells:
            navigationController?.pushViewController(ListItemCellsViewController(), animated: true)
        case .userComparsion:
            navigationController?.pushViewController(TwoUserComparsionCellsViewController(), animated: true)
        case .graphCells:
            navigationController?.pushViewController(GraphCellsViewController(), animated: true)
        }
    }
}

