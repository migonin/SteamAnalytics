//
//  GameListViewController.swift
//  UICommonTestApp
//
//  Created by Михаил Игонин on 29.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UIKit
import UICommon

class GameListViewController: UITableViewController {

    let dataSource: [ListItemCellModel] = [
        ListItemCellModel(
            title: "CS: GO",
            subtitle: nil,
            imgUrl: "http://media.steampowered.com/steamcommunity/public/images/apps/730/69f7ebe2735c366c65c0b33dae00e12dc40edbe4.jpg",
            showDisclosureIndicator: true
        ),

        ListItemCellModel(
            title: "CS: GO",
            subtitle: nil,
            imgUrl: "http://media.steampowered.com/steamcommunity/public/images/apps/730/69f7ebe2735c366c65c0b33dae00e12dc40edbe4.jpg",
            showDisclosureIndicator: true
        ),

        ListItemCellModel(
            title: "CS: GO",
            subtitle: nil,
            imgUrl: "http://media.steampowered.com/steamcommunity/public/images/apps/730/69f7ebe2735c366c65c0b33dae00e12dc40edbe4.jpg",
            showDisclosureIndicator: true
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        title = "Список игр"
        tableView.registerClassCell(ListItemCell.self)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableTypedCell(for: indexPath, cellType: ListItemCell.self)
        cell.configure(with: dataSource[indexPath.row])

        return cell
    }
}

