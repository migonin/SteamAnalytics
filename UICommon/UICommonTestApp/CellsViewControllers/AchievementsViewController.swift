//
//  AchievementsViewController.swift
//  UICommonTestApp
//
//  Created by Михаил Игонин on 29.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UIKit
import UICommon

class AchievementsViewController: UITableViewController {

    let dataSource: [TitleAndTextCellModel] = [
        TitleAndTextCellModel(
            title: "Short Fuse",
            description: "Plant a bomb within 25 seconds (excluding Demolition mode)",
            imgUrl: "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/apps/730/648550738f4845f12aa686a1b4ee8c4a51ec2348.jpg"
        ),

        TitleAndTextCellModel(
            title: "Short Fuse",
            description: "Plant a bomb within 25 seconds (excluding Demolition mode)",
            imgUrl: "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/apps/730/648550738f4845f12aa686a1b4ee8c4a51ec2348.jpg"
        ),

        TitleAndTextCellModel(
            title: "Short Fuse",
            description: "Plant a bomb within 25 seconds (excluding Demolition mode)",
            imgUrl: "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/apps/730/648550738f4845f12aa686a1b4ee8c4a51ec2348.jpg"
        ),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        title = "Ачивки"
        tableView.registerClassCell(TitleAndTextCell.self)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableTypedCell(for: indexPath, cellType: TitleAndTextCell.self)
        cell.configure(with: dataSource[indexPath.row])

        return cell
    }
}

