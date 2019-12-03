//
//  WebViewLoginURLDescribing.swift
//  LoginScenes
//
//  Created by Михаил Игонин on 30.10.2019.
//  Copyright © 2019 YouDo. All rights reserved.
//

import Foundation

protocol WebViewLoginURLDescribing {
    func describeUrl(_ url: URL?) -> WebViewURLType
}
