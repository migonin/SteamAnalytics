//
//  GraphCellsViewController.swift
//  UICommonTestApp
//
//  Created by Михаил Игонин on 29.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UIKit
import UICommon

class GraphCellsViewController: UITableViewController {

    let dataSource: [GraphCellModel] = [
        GraphCellModel(title: "Первый показатель", values: [

            (Date().addingTimeInterval(-170), 40),
            (Date().addingTimeInterval(-160), 10),
            (Date().addingTimeInterval(-150), 80),
            (Date().addingTimeInterval(-140), 20),
            (Date().addingTimeInterval(-130), 10),
            (Date().addingTimeInterval(-120), 50),
            (Date().addingTimeInterval(-110), 100),
            (Date().addingTimeInterval(-100), 10),
            (Date().addingTimeInterval(-90), 40),
            (Date().addingTimeInterval(-80), 10),
            (Date().addingTimeInterval(-70), 80),
            (Date().addingTimeInterval(-60), 20),
            (Date().addingTimeInterval(-50), 10),
            (Date().addingTimeInterval(-40), 50),
            (Date().addingTimeInterval(-30), 100),
            (Date().addingTimeInterval(-20), 10),
            (Date().addingTimeInterval(-10), 0),
            (Date(), 100)
        ]),

        GraphCellModel(title: "Второй показатель", values: [

            (Date().addingTimeInterval(-170), 40),
            (Date().addingTimeInterval(-160), 10),
            (Date().addingTimeInterval(-150), 80),
            (Date().addingTimeInterval(-140), 20),
            (Date().addingTimeInterval(-130), 10),
            (Date().addingTimeInterval(-120), 50),
            (Date().addingTimeInterval(-110), 100),
            (Date().addingTimeInterval(-100), 10),
            (Date().addingTimeInterval(-90), 40),
            (Date().addingTimeInterval(-80), 10),
            (Date().addingTimeInterval(-70), 80),
            (Date().addingTimeInterval(-60), 20),
            (Date().addingTimeInterval(-50), 10),
            (Date().addingTimeInterval(-40), 50),
            (Date().addingTimeInterval(-30), 100),
            (Date().addingTimeInterval(-20), 10),
            (Date().addingTimeInterval(-10), 0),
            (Date(), 100)
        ])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        title = "GraphCells"
        tableView.registerClassCell(GraphCell.self)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableTypedCell(for: indexPath, cellType: GraphCell.self)
        cell.configure(with: dataSource[indexPath.row])

        return cell
    }
}

