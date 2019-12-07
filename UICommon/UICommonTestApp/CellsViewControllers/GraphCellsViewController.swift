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
    var savedTransform: CGAffineTransform? = nil

    func generateRandomDataSet() -> [(Date, Int)] {
        var dataSet: [(Date, Int)] = []
        var lastVal: Int = 0

        for i in (0..<20).reversed() {
            let random = Int.random(in: 0..<20)
            let val = lastVal + ((random < 10) ? 0 : random)

            lastVal = val
            dataSet.append(((Date().addingTimeInterval(TimeInterval(-i * 12 * 3600))), val))
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
                           transformHandler: transformHandler),

            GraphCellModel(title: "Второй показатель",
                           id: "2",
                           values: generateRandomDataSet(),
                           transformHandler: transformHandler),

            GraphCellModel(title: "Третий показатель",
                           id: "3",
                           values: generateRandomDataSet(),
                           transformHandler: transformHandler),

            GraphCellModel(title: "Четвертый показатель",
                           id: "4",
                           values: generateRandomDataSet(),
                           transformHandler: transformHandler),

            GraphCellModel(title: "Пятый показатель",
                           id: "5",
                           values: generateRandomDataSet(),
                           transformHandler: transformHandler),

            GraphCellModel(title: "Шестой показатель",
                           id: "6",
                           values: generateRandomDataSet(),
                           transformHandler: transformHandler),

            GraphCellModel(title: "Седьмой показатель",
                           id: "7",
                           values: generateRandomDataSet(),
                           transformHandler: transformHandler)
        ]

        title = "Статистика игры"
        tableView.registerClassCell(GraphCell.self)

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableTypedCell(for: indexPath, cellType: GraphCell.self)
        cell.configure(with: dataSource[indexPath.row])
        cell.setTransform(savedTransform)

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

