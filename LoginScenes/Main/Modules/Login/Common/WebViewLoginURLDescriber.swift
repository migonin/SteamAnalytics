//
//  WebViewLoginURLDescriber.swift
//  LoginScenes
//
//  Created by Михаил Игонин on 30.10.2019.
//  Copyright © 2019 YouDo. All rights reserved.
//

import Foundation

class WebViewLoginURLDescriber: WebViewLoginURLDescribing {
    var loggedInHost = "login"
    var loggedInPath = "/loggedin"
    var idParameterName = "openid.identity"
    var idPrefix = "https://steamcommunity.com/openid/id/"

    func describeUrl(_ url: URL?) -> WebViewURLType {
        guard
            url?.host == loggedInHost,
            url?.path == loggedInPath,
            let urlString = url?.absoluteString,
            let queryItems = URLComponents(string: urlString)?.queryItems?.reduce(into: [String: String](), { (result, item) in
                result[item.name] = item.value
            }),

            let idString = queryItems[idParameterName],
            idString.hasPrefix(idPrefix)
        else {
            return .other
        }

        let id = String(idString.dropFirst(idPrefix.count))
        return .loggedIn(id: id)
    }
}
