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
        let game = Game(id: 730, name: "", icon: "", logo: "")

//        Services.gamesService.getUserGames(user) { (_) in
//            print("")
//        }

//        Services.gamesService.getGamesStats(game, of: user) { _ in
//            print("")
//        }
        let games = Storages.gamesStorage.getUserGames(user)
        let acheivements = Storages.gamesStorage.getGameAchievements(game, user: user)
        let stats = Storages.gamesStorage.getGameStats(game, user: user)

        print("")
    }


}

