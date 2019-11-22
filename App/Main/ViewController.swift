//
//  ViewController.swift
//  App
//
//  Created by Михаил Игонин on 20.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UIKit
import Dependencies

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let id = "76561198324029511"

        Services.usersService.getUser(withID: id) { (result) in
            if let user = Storages.usersStorage.getUser(withID: id) {
                Services.usersService.getUserFriends(user) { (result) in
                    let friends = user.friends
                    print("")
                }
            }
        }
    }


}

