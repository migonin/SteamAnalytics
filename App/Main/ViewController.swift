//
//  ViewController.swift
//  App
//
//  Created by Михаил Игонин on 20.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UIKit
import Dependencies
import Storages
import Core

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let id = "76561198324029511"

        let user = User(id: id, name: "", isProfileVisible: true, status: .online, avatar: "", avatarMedium: "", avatarFull: "", lastLogOff: 0)

        Services.gamesService.getUserGames(user) { (result) in
        }
    }


}

