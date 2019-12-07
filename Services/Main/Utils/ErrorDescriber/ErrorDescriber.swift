//
//  ErrorDescriber.swift
//  Services
//
//  Created by Михаил Игонин on 01.12.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import Alamofire
import UICommon

public class ErrorDescriber: ErrorDescribing {
    public init() { }

    public func describeError(_ error: Error) -> ErrorType {
        //TODO Localize
        if (error as NSError).domain == NSURLErrorDomain {
            return .networkError(text: L10n.Error.internet, okMessage: L10n.Common.back, retryMessage: L10n.Common.retry)
        } else if let error = error as? AFError {
            if error.isSessionTaskError {
                return .networkError(text: L10n.Error.internet, okMessage: L10n.Common.back, retryMessage: L10n.Common.retry)
            } else {
                return .wrongResponse
            }
        } else {
            return .message(text: L10n.Error.general, okMessage: L10n.Common.back, retryMessage: L10n.Common.retry)
        }
    }
}
