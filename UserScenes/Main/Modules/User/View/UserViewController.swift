//
//  UserViewController.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UIKit
import UICommon
import SnapKit

class UserViewController: BaseTableViewController, UserViewInput {
    var output: UserViewOutput!
    var itemsSource: UserItemsSourcing!

    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.didLoad()
    }

    override func registerCells() {
        tableView.registerClassCell(HeaderCell.self)
        tableView.registerClassCell(ListItemCell.self)
        tableView.registerClassCell(MessageCell.self)
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

    @objc func logoutTapped() {
        output.logoutButtonTapped()
    }

    override func refresh() {
        output.didRefresh()
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
        case .header(let model):
            let cell = tableView.dequeueReusableTypedCell(for: indexPath, cellType: HeaderCell.self)
            cell.configure(with: model)

            return cell
        case .games(let model), .friends(let model):
            let cell = tableView.dequeueReusableTypedCell(for: indexPath, cellType: ListItemCell.self)
            cell.configure(with: model)

            return cell

        case  .privateProfile(let model):
            let cell = tableView.dequeueReusableTypedCell(for: indexPath, cellType: MessageCell.self)
            cell.configure(with: model)

            return cell

        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.didTapCell(at: indexPath.row)
    }

    // MARK: - Alerts

    override func errorAlertOKButtonTapped() {
        output.didTapOKButton()
    }

    override func errorAlertRetryButtonTapped() {
        output.didTapRetryButton()
    }

    // MARK: - UserViewInput
    func addLogoutButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: L10n.User.logout, style: .plain, target: self, action: #selector(logoutTapped))
    }

    func showLogoutPopup() {
        let alertController = UIAlertController(title: "", message: L10n.User.LogoutPopup.text, preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: L10n.User.LogoutPopup.confirm, style: .destructive, handler: { [weak self] (_) in
            self?.output.logoutConfirmed()
        }))

        alertController.addAction(UIAlertAction(title: L10n.User.LogoutPopup.cancel, style: .default, handler: { (_) in

        }))

        present(alertController, animated: true)
    }

}
