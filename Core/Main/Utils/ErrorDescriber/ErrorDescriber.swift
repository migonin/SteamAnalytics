//
//  ErrorDescriber.swift
//  Services
//
//  Created by Михаил Игонин on 01.12.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Alamofire

public class ErrorDescriber: ErrorDescribing {
    public init() { }

    public func describeError(_ error: Error) -> ErrorType {
        //TODO Localize
        if (error as NSError).domain == NSURLErrorDomain {
            return .networkError(text: "Проблемы с инернетом.", okMessage: "Назад", retryMessage: "Повторить")
        } else if let error = error as? AFError {
            if error.isSessionTaskError {
                return .networkError(text: "Проблемы с инернетом.", okMessage: "Назад", retryMessage: "Повторить")
            } else {
                return .wrongResponse
            }
        } else {
            return .message(text: "Что-то пошло не так.", okMessage: "Назад", retryMessage: "Повторить")
        }
    }
}
