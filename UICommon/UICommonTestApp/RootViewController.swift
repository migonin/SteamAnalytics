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
        case user = "Экран юзера"
        case game = "Экран игры"
        case userList = "Список юзеров"
        case gameList = "Список игр"
        case userComparsion = "Сравнение пользователей"
        case graphCells = "Статистика игры"
        case achievements = "Ачивки"
        case news = "Новости"
    }

    let dataSource = Row.allCases

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        title = "Экраны"
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
        case .user:
            navigationController?.pushViewController(UserViewController(), animated: true)
        case .game:
            navigationController?.pushViewController(GameViewController(), animated: true)
        case .userList:
            navigationController?.pushViewController(UserListViewController(), animated: true)
        case .gameList:
            navigationController?.pushViewController(GameListViewController(), animated: true)
        case .userComparsion:
            navigationController?.pushViewController(ComparsionViewController(), animated: true)
        case .graphCells:
            navigationController?.pushViewController(GraphCellsViewController(), animated: true)
        case .achievements:
            navigationController?.pushViewController(AchievementsViewController(), animated: true)
        case .news:
            navigationController?.pushViewController(NewsViewController(), animated: true)

        }
    }
}

