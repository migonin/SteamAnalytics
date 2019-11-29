//
//  HeaderCellsViewController.swift
//  UICommonTestApp
//
//  Created by Михаил Игонин on 29.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UIKit
import UICommon

class HeaderCellsViewController: UITableViewController {

    let dataSource: [HeaderCellModel] = [
        HeaderCellModel(
            title: "Header Cell",
            subtitle: "With subtitle and rounded image",
            imgUrl: "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/c0/c0428498c7dee5b9e156e743af2d849a9fa66a90_full.jpg",
            roundedImg: true
        ),

        HeaderCellModel(
            title: "Header Cell",
            subtitle: "With subtitle and nor rounded image",
            imgUrl: "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/c0/c0428498c7dee5b9e156e743af2d849a9fa66a90_full.jpg",
            roundedImg: false
        ),

        HeaderCellModel(
            title: "Header Cell Without Subtitle",
            subtitle: nil,
            imgUrl: "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/c0/c0428498c7dee5b9e156e743af2d849a9fa66a90_full.jpg",
            roundedImg: false
        ),

        HeaderCellModel(
            title: "Header Cell With Title, Subtitle, Rounded Img, And many lines of text.",
            subtitle: "Header Cell With Title, Subtitle, Rounded Img, And many lines of text. Header Cell With Title, Subtitle, Rounded Img, And many lines of text. Header Cell With Title, Subtitle, Rounded Img, And many lines of text.",
            imgUrl: "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/c0/c0428498c7dee5b9e156e743af2d849a9fa66a90_full.jpg",
            roundedImg: true
        )

    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        title = "HeaderCells"
        tableView.registerClassCell(HeaderCell.self)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableTypedCell(for: indexPath, cellType: HeaderCell.self)
        cell.configure(with: dataSource[indexPath.row])

        return cell
    }
}

