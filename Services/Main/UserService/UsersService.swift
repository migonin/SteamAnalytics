//
//  UsersService.swift
//  Services
//
//  Created by Михаил Игонин on 22.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import APIClient
import Storages
import Core

public struct UsersService: UsersServicing {
    let urlFactory: URLFactoring
    let urlRequestFactory: URLRequestFactoring
    let usersAPIClient: UsersAPIClienting
    let storage: UsersStorageInput
    let timeout: TimeInterval

    public init(urlFactory: URLFactoring,
                urlRequestFactory: URLRequestFactoring,
                userAPIClient: UsersAPIClienting,
                storage: UsersStorageInput,
                timeout: TimeInterval) {
        self.urlFactory = urlFactory
        self.urlRequestFactory = urlRequestFactory
        self.usersAPIClient = userAPIClient
        self.storage = storage
        self.timeout = timeout
    }

    public func getUser(withID id: String, completionHandler: @escaping ServiceCompletion) {
        let url: URL
        let request: URLRequest

        do {
            url = try urlFactory.buildURL(methodPath: .usersDetails)
            request = try urlRequestFactory.buildRequest(url: url, query: UsersQuery(userIds: [id]), timeoutInterval: timeout)
        } catch {
            completionHandler(.failure(error))
            return
        }

        usersAPIClient.getUsers(request: request) { (result) in
            switch result {
            case .success(let response):
                if let user = response.response.players.first {
                    self.storage.createOrUpdateUsers([user]) {
                        completionHandler(.success(()))
                    }
                } else {
                    completionHandler(.failure(NetworkingError.wrongResponse))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

    public func getUserFriends(_ user: User, completionHandler: @escaping ServiceCompletion) {
        let url: URL
        let request: URLRequest

        do {
            url = try urlFactory.buildURL(methodPath: .userFriends)
            request = try urlRequestFactory.buildRequest(url: url, query: UserQuery(userId: user.id), timeoutInterval: timeout)
        } catch {
            completionHandler(.failure(error))
            return
        }

        usersAPIClient.getUserFriends(request: request) { (result) in
            switch result {
            case .success(let response):
                let friendIDs = response.friendslist.friends.map({$0.steamid})

                // Steam API return only friend ids, not full profiles, so let's chain it to user request
                self.getUsers(withIDs: friendIDs) { (result) in
                    switch result {
                    case .success(let friends):
                        self.storage.setFriends(friends, to: user)

                        completionHandler(.success(()))

                    case .failure(let error):
                        completionHandler(.failure(error))
                    }
                }

            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

    // MARK: Helpers
    private func getUsers(withIDs ids: [String], completionHandler: @escaping (Result<[User], Error>) -> Void) {
        let url: URL
        let request: URLRequest

        do {
            url = try self.urlFactory.buildURL(methodPath: .usersDetails)
            request = try self.urlRequestFactory.buildRequest(url: url, query: UsersQuery(userIds: ids), timeoutInterval: timeout)
        } catch {
            completionHandler(.failure(error))
            return
        }

        usersAPIClient.getUsers(request: request) { (result) in
            switch result {
            case .success(let response):
                //OMG, API returns friends with random order...
                let orderedFriends = self.reoderUsers(response.response.players, ids: ids)
                completionHandler(.success(orderedFriends))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

    private func reoderUsers(_ users: [User], ids: [String]) -> [User] {
        var retArray: [User] = []

        for id in ids {
            if let userWithId = users.first(where: {$0.id == id}) {
                retArray.append(userWithId)
            }
        }

        return retArray
    }
}
