//
//  AchievementsViewController.swift
//  UICommonTestApp
//
//  Created by Михаил Игонин on 29.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UIKit
import UICommon

class NewsViewController: UITableViewController {

    var htmlString: NSAttributedString {
        let text =  "<a href=\"https://steamcommunity.com/groups/potatomvmservers/announcements/detail/3603371708564850840\"><img src=\"https://steamcdn-a.akamaihd.net/steam/news/56399/download.jpeg?t=1496190709\"></a>\n(Image credit - <a href=\"https://steamcommunity.com/profiles/76561198045651005\">Mayor Rev</a>)<br><br>\n\n<p><a href=\"https://steamcommunity.com/groups/potatomvmservers/announcements/detail/3603371708564850840\">Operation Madness vs Machines</a> is finally here!</p><br>\n\n<p>Brought to you by the same group behind <a href=\"https://steamcommunity.com/groups/potatomvmservers/announcements/detail/1663388904536296299\">Titanium Tank</a>, <a href=\"https://www.teamfortress.com/post.php?id=46099\">Canteen Crasher</a>, and <a href=\"https://www.teamfortress.com/post.php?id=49544\">Memes vs Machines</a>, <b>Operation Madness vs Machines</b> features <b>98</b> new missions across <b>45</b> community maps, including <b>13</b> new maps! Five new gem medals and two new charity medals are up for grabs!</p><br>\n\n<p>Madness vs Machines throws a new <b>cooperative</b> twist into the mix: Instead of working individually on your contracts, all participants work together as a massive team to complete the global co-op community contracts! A stockpile of precious gems ripped from robot arms (with their hands included, mind you!) awaits those who prove themselves in the war against the metal menace!</p><br>\n\n<p>To top it all off, there's a <b>charity drive</b> to raise money for <a href=\"https://potato.tf/charity\">Extra Life</a>!. All funds go straight to the cause, so while you battle the robot horde at the frontlines, you can help save children's lives back at home! <a href=\"https://potato.tf/charity\">Click here for instructions on how to donate</a> and earn the prestigious heart gems!</p><br>\n\n<p>This event is open to players of all skill levels. Official servers are available <b>worldwide</b> in <a href=\"https://potato.tf/servers/SGP\">Asia</a>, <a href=\"https://potato.tf/servers/AU\">Australia</a>, <a href=\"https://potato.tf/servers/ARG\">South America</a>, <a href=\"https://potato.tf/servers/EU\">Europe</a>, and <a href=\"https://potato.tf/servers/PHL\">North America</a>. Free private servers are available for groups that wish to play together.</p><br>\n\nNo registration is necessary to participate. <a href=\"https://potato.tf/servers\">Click here to start playing!</a></p><br>\n\n<p>Important Links:<ul>\n<li><a href=\"https://potato.tf/servers\">Servers List</a>\n<li><a href=\"https://potato.tf/charity\">Charity Page</a>\n<li><a href=\"https://steamcommunity.com/groups/potatomvmservers/announcements/detail/3603371708564850840\">Event Information</a>\n<li><a href=\"https://potato.tf\">Official Website</a>\n<li><a href=\"https://steamcommunity.com/gid/103582791457822588\">Steam Group</a></ul></p><br>\n"

        let fontFixedText = "<span style=\"font-family: Helvetica; font-size: 16; color: gray\">\(text)</span>"

        let htmlData = fontFixedText.data(using: .utf8)!

        return try! NSAttributedString(
            data: htmlData,
            options: [.documentType: NSAttributedString.DocumentType.html,],
            documentAttributes: nil
        )
    }

    var dataSource: [NewsEntryCellModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        title = "Новости"
        tableView.registerClassCell(NewsEntryCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100

        dataSource = [
            NewsEntryCellModel(
                title: "Operation Madness vs Machines!",
                date: "01.01.1970",
                text: htmlString
            )
        ]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableTypedCell(for: indexPath, cellType: NewsEntryCell.self)
        cell.configure(with: dataSource[indexPath.row])

        return cell
    }
}

