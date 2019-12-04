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
    var savedTransform = CGAffineTransform.identity

    func generateRandomDataSet() -> [(Date, Int)] {
        var dataSet: [(Date, Int)] = []

        for i in (0..<20).reversed() {
            dataSet.append(((Date().addingTimeInterval(TimeInterval(-i * 3600))), Int.random(in: 0..<100)))
        }

        return dataSet
    }

    var dataSource: [GraphCellModel]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        dataSource = [
            GraphCellModel(title: "Первый показатель",
                           id: "1",
                           values: generateRandomDataSet(),
                           initialTransform: CGAffineTransform.identity,
                           transformHandler: transformHandler),

            GraphCellModel(title: "Второй показатель",
                           id: "2",
                           values: generateRandomDataSet(),
                           initialTransform: CGAffineTransform.identity,
                           transformHandler: transformHandler),

            GraphCellModel(title: "Третий показатель",
                           id: "3",
                           values: generateRandomDataSet(),
                           initialTransform: CGAffineTransform.identity,
                           transformHandler: transformHandler),

            GraphCellModel(title: "Четвертый показатель",
                           id: "4",
                           values: generateRandomDataSet(),
                           initialTransform: CGAffineTransform.identity,
                           transformHandler: transformHandler),

            GraphCellModel(title: "Пятый показатель",
                           id: "5",
                           values: generateRandomDataSet(),
                           initialTransform: CGAffineTransform.identity,
                           transformHandler: transformHandler),

            GraphCellModel(title: "Шестой показатель",
                           id: "6",
                           values: generateRandomDataSet(),
                           initialTransform: CGAffineTransform.identity,
                           transformHandler: transformHandler),

            GraphCellModel(title: "Седьмой показатель",
                           id: "7",
                           values: generateRandomDataSet(),
                           initialTransform: CGAffineTransform.identity,
                           transformHandler: transformHandler),
        ]

        title = "GraphCells"
        tableView.registerClassCell(GraphCell.self)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableTypedCell(for: indexPath, cellType: GraphCell.self)
        var model = dataSource[indexPath.row]
        model.initialTransform = savedTransform

        cell.configure(with: model)

        return cell
    }

    func transformHandler(id: String, transform: CGAffineTransform) {
        savedTransform = transform

        for cell in tableView.visibleCells {
            if let graphCell = cell as? GraphCell, graphCell.id != id {
                graphCell.updateTransform(transform)
            }
        }
    }
}

