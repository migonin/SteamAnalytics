//
//  Requestable.swift
//  APIClient
//
//  Created by Михаил Игонин on 21.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Alamofire

protocol Requestable {
    var queue: DispatchQueue { get }
    var decoder: DataDecoder { get }
}

extension Requestable {
    func requestDecodable<ResponseType: Codable>(_ request: URLRequest, completionHandler: @escaping (Result<ResponseType, Error>) -> Void) {

        AF.request(request).responseDecodable(of: ResponseType.self, queue: queue, decoder: decoder) { (response) in
            // Cannot convert Result<_, AFError> to Result<_, Error>, omg
            switch response.result {
            case .failure(let error):
                completionHandler(.failure(error as Error))
            case .success(let response):
                completionHandler(.success(response))
            }
        }
    }
}
