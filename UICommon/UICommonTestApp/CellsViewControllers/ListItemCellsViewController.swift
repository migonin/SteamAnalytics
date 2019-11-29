//
//  ListItemCellsViewController.swift
//  UICommonTestApp
//
//  Created by Михаил Игонин on 29.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UIKit
import UICommon

class ListItemCellsViewController: UITableViewController {

    let dataSource: [ListItemCellModel] = [
        ListItemCellModel(
            title: "Vasiliy Pupkin",
            subtitle: nil,
            imgUrl: "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/c0/c0428498c7dee5b9e156e743af2d849a9fa66a90_medium.jpg",
            showDisclosureIndicator: true
        ),

        ListItemCellModel(
            title: "Vasiliy Pupkin",
            subtitle: "Gamer",
            imgUrl: "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/c0/c0428498c7dee5b9e156e743af2d849a9fa66a90_medium.jpg",
            showDisclosureIndicator: true
        ),

        ListItemCellModel(
            title: "Games",
            subtitle: nil,
            imgUrl: nil,
            showDisclosureIndicator: true
        ),

        ListItemCellModel(
            title: "Games",
            subtitle: "100500",
            imgUrl: nil,
            showDisclosureIndicator: true
        ),

        ListItemCellModel(
            title: "Some stat",
            subtitle: "12345",
            imgUrl: nil,
            showDisclosureIndicator: false
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        title = "ListItemCells"
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

