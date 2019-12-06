//
//  GameAchievementsViewController.swift
//  GameAchievementsScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UIKit
import UICommon
import SnapKit

class GameAchievementsViewController: BaseTableViewController, GameAchievementsViewInput {
    var output: GameAchievementsViewOutput!
    var itemsSource: GameAchievementsItemsSourcing!

    var currentTransform: CGAffineTransform? = nil

    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        output.didLoad()
    }

    override func registerCells() {
        tableView.registerClassCell(ListItemWithDescriptionCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        output.willAppear(animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        output.didAppear(animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        output.willDisappear(animated: animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        output.didDisappear(animated: animated)
    }

    func reloadData() {
        tableView.reloadData()
    }

    // MARK: - Table view

    func numberOfSections(in tableView: UITableView) -> Int {
        return itemsSource.numberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsSource.itemsInSection(index: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = itemsSource.itemModelFor(indexPath: indexPath)

        switch model {
        case .achievement(let model):
            let cell = tableView.dequeueReusableTypedCell(for: indexPath, cellType: ListItemWithDescriptionCell.self)
            cell.configure(with: model)

            return cell
        }
    }

    // MARK: - GameAchievementsViewInput
}
