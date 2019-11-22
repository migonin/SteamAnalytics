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

public struct UsersService: UsersServicing {
    let urlFactory: URLFactoring
    let urlRequestFactory: URLRequestFactoring
    let usersAPIClient: UsersAPIClienting
    let mapper: UserMapping
    let storage: UsersStorageInput
    let timeout: TimeInterval

    public init(urlFactory: URLFactoring,
                urlRequestFactory: URLRequestFactoring,
                userAPIClient: UsersAPIClienting,
                mapper: UserMapping,
                storage: UsersStorageInput,
                timeout: TimeInterval) {
        self.urlFactory = urlFactory
        self.urlRequestFactory = urlRequestFactory
        self.usersAPIClient = userAPIClient
        self.mapper = mapper
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
                if let userResonse = response.response.players.first {
                    let userStruct = self.mapper.mapApiUserToStorageStruct(userResonse)

                    self.storage.createOrUpdateUsers([userStruct])

                    completionHandler(.success(()))
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
            request = try urlRequestFactory.buildRequest(url: url, query: UserQuery(userId: user.id.value), timeoutInterval: timeout)
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
                    case .success(let users):
                        let userStructs = users.map({self.mapper.mapApiUserToStorageStruct($0)})

                        self.storage.setFriends(userStructs, to: user)

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
    private func getUsers(withIDs ids: [String], completionHandler: @escaping (Result<[APIUser], Error>) -> Void) {
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
                completionHandler(.success(response.response.players))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
