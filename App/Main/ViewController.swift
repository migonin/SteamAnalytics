//
//  ViewController.swift
//  App
//
//  Created by Михаил Игонин on 20.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UIKit
import APIClient

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let urlFactory: URLFactoring = URLFactory(baseURL: "https://api.steampowered.com")
        let urlRequestFactory: URLRequestFactoring = URLRequestFactory()
        let userRequestFactory: UsersRequestFactoring = AlamofireUsersRequestFactory()

        let url = try! urlFactory.buildURL(methodPath: .usersDetails)
        let request = try! urlRequestFactory.buildRequest(url: url, query: UsersQuery(userIds: [76561198324029511]), timeoutInterval: 60.0)

        userRequestFactory.getUsers(request: request) { (reult) in
            print("")
        }
    }


}

