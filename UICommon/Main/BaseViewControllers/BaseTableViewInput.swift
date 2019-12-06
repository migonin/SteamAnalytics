//
//  BaseTableViewInput.swift
//  UICommon
//
//  Created by Михаил Игонин on 03.12.2019.
//  Copyright © 2019 YouDo. All rights reserved.
//

import Foundation

public protocol BaseTableViewInput: BaseViewInput {
    func reloadData()

    func setPullToRefreshActive(_ isActive: Bool)
    func setPullToRefreshEnabled(_ isEnabled: Bool)
}
