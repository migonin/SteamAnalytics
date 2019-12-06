//
//  GameViewController.swift
//  UICommonTestApp
//
//  Created by Михаил Игонин on 29.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UIKit
import UICommon

class GameViewController: UITableViewController {

    let dataSource: [Any] = [
        HeaderCellModel(
            title: "CS: GO",
            subtitle: "Всего 100500 часов",
            subsubtitle: "На этой неделе 40 часов",
            imgUrl: "http://media.steampowered.com/steamcommunity/public/images/apps/730/d0595ff02f5c79fd19b06f4d6165c3fda2372820.jpg",
            roundedImg: false,
            alignment: .leading
        ),

        ListItemCellModel(
            title: "Новости",
            subtitle: nil,
            imgUrl: nil,
            showDisclosureIndicator: true
        ),

        ListItemCellModel(
            title: "Ачивки",
            subtitle: nil,
            imgUrl: nil,
            showDisclosureIndicator: true
        ),

        ListItemCellModel(
            title: "Статы",
            subtitle: nil,
            imgUrl: nil,
            showDisclosureIndicator: true
        ),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        title = "CS: GO"
        tableView.registerClassCell(HeaderCell.self)
        tableView.registerClassCell(ListItemCell.self)
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

