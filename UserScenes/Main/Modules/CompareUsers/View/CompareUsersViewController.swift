//
//  CompareUsersViewController.swift
//  CompareUsersScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UIKit
import UICommon
import SnapKit
import Core

class CompareUsersViewController: BaseTableViewController, CompareUsersViewInput {
    var output: CompareUsersViewOutput!
    var itemsSource: CompareUsersItemsSourcing!

    let pickerHidingView = UIView()
    let pickerView = UIPickerView()
    let toolBar = UIToolbar()

    var games: [Game] = []
    var selectedGame: Game?

    // MARK: View life cycle

    override func loadView() {
        super.loadView()

        setupPickerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        output.didLoad()
    }

    func setupPickerView() {
        pickerHidingView.isHidden = true
        pickerHidingView.backgroundColor = UIColor.black.withAlphaComponent(0.7)

        view.addSubview(pickerHidingView)

        pickerHidingView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        pickerHidingView.addSubview(pickerView)

        pickerView.delegate = self
        pickerView.dataSource = self

        if #available(iOS 13.0, *) {
            pickerView.backgroundColor = .systemBackground
        } else {
            pickerView.backgroundColor = .white
        }

        pickerView.snp.makeConstraints { (make) in
            if #available(iOS 11, *) {
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            } else {
                make.bottom.equalTo(bottomLayoutGuide.snp.bottom)
            }

            make.left.right.equalToSuperview()
            make.height.equalTo(200)
        }

        pickerHidingView.addSubview(toolBar)

        toolBar.barStyle = .black

        toolBar.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(pickerView.snp.top)
//            make.height.equalTo(50)
        }

        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(hideGameSelector))]
    }

    override func registerCells() {
        tableView.registerClassCell(TwoUsersCell.self)
        tableView.registerClassCell(ListItemCell.self)
        tableView.registerClassCell(ComparisonCell.self)
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
            let cell = tableView.dequeueReusableTypedCell(for: indexPath, cellType: TwoUsersCell.self)
            cell.configure(with: model)
            return cell

            case .chooseGame(let model):
                let cell = tableView.dequeueReusableTypedCell(for: indexPath, cellType: ListItemCell.self)
                cell.configure(with: model)

                return cell

            case .comarisonResult(let model):
                let cell = tableView.dequeueReusableTypedCell(for: indexPath, cellType: ComparisonCell.self)
                cell.configure(with: model)

                return cell

            case .noGames(let model), .noStats(let model):
                let cell = tableView.dequeueReusableTypedCell(for: indexPath, cellType: MessageCell.self)
                cell.configure(with: model)

                return cell

        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.didTapCell(at: indexPath.row)
    }

    // MARK: - CompareUsersViewInput
    func showGameSelector(_ games: [Game]) {
        self.games = games
        pickerView.reloadAllComponents()
        pickerHidingView.isHidden = false
    }

    @objc func hideGameSelector() {
        pickerHidingView.isHidden = true
        output.didSelectGame(selectedGame)
    }
}

extension CompareUsersViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return games.count
    }
}

extension CompareUsersViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return games[row].name
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedGame = games[row]
    }
}
