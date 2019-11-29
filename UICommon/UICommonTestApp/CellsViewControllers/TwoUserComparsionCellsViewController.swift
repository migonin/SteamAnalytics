//
//  TwoUserComparsionCellsViewController.swift
//  UICommonTestApp
//
//  Created by Михаил Игонин on 29.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UIKit
import UICommon

class TwoUserComparsionCellsViewController: UITableViewController {

    let dataSource: [Any] = [
        TwoUsersCellModel(leftTitle: "Vasya",
                          leftImgUrl: "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/c0/c0428498c7dee5b9e156e743af2d849a9fa66a90_medium.jpg",
                          rightTitle: "Petya",
                          rightImgUrl: "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/c0/c0428498c7dee5b9e156e743af2d849a9fa66a90_medium.jpg"
        ),

        ComparsionCellModel(title: "Показатель", leftValue: 10, rightValue: 20),
        ComparsionCellModel(title: "Другой показатель", leftValue: 1000, rightValue: 20),
        ComparsionCellModel(title: "Третий показатель", leftValue: 10, rightValue: 10),
        ComparsionCellModel(title: "Еще показатель", leftValue: 100500, rightValue: 20),

    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        title = "TwoUserCells"
        tableView.registerClassCell(TwoUsersCell.self)
        tableView.registerClassCell(ComparsionCell.self)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = dataSource[indexPath.row]

        if let model = model as? TwoUsersCellModel {
            let cell = tableView.dequeueReusableTypedCell(for: indexPath, cellType: TwoUsersCell.self)
            cell.configure(with: model)

            return cell
        } else if let model = model as? ComparsionCellModel {
            let cell = tableView.dequeueReusableTypedCell(for: indexPath, cellType: ComparsionCell.self)
            cell.configure(with: model)

            return cell
        } else {
            fatalError("Unknown model")
        }
    }
}

