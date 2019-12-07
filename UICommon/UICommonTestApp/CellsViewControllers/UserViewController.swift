//
//  UserViewController.swift
//  UICommonTestApp
//
//  Created by Михаил Игонин on 29.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UIKit
import UICommon

class UserViewController: UITableViewController {

    let dataSource: [Any] = [
        HeaderCellModel(
            title: "Vasiliy Pupkin",
            subtitle: "Online",
            imgUrl: "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/c0/c0428498c7dee5b9e156e743af2d849a9fa66a90_full.jpg",
            roundedImg: true
        ),

        ListItemCellModel(
            title: "Игры",
            subtitle: nil,
            imgUrl: nil,
            showDisclosureIndicator: true
        ),

        ListItemCellModel(
            title: "Друзья",
            subtitle: nil,
            imgUrl: nil,
            showDisclosureIndicator: true
        ),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        title = "Vasiliy Pupkin"
        tableView.registerClassCell(HeaderCell.self)
        tableView.registerClassCell(ListItemCell.self)

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = dataSource[indexPath.row]

        if let model = model as? HeaderCellModel {
            let cell = tableView.dequeueReusableTypedCell(for: indexPath, cellType: HeaderCell.self)
            cell.configure(with: model)

            return cell
        } else if let model = model as? ListItemCellModel {
            let cell = tableView.dequeueReusableTypedCell(for: indexPath, cellType: ListItemCell.self)
            cell.configure(with: model)

            return cell
        } else {
            fatalError("Unknown model")
        }
    }
}

