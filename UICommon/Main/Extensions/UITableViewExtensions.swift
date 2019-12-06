//
//  UITableViewExtensions.swift
//  UICommon
//
//  Created by Михаил Игонин on 29.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import UIKit

public extension UITableView {
    func defaultReuseIdentifier(for some: AnyClass) -> String {
        return String(describing: some)
    }

    func registerClassCell<T: UITableViewCell>(_: T.Type) {
        self.register(T.self, forCellReuseIdentifier: defaultReuseIdentifier(for: T.self))
    }

    func dequeueReusableTypedCell<T: UITableViewCell>(for indexPath: IndexPath,
                                                      cellType: T.Type) -> T {
        let identifier = defaultReuseIdentifier(for: T.self)

        let dequeuedCell = self.dequeueReusableCell(withIdentifier: identifier,
                                                    for: indexPath)

        guard let cell = dequeuedCell as? T else {
            fatalError("Could not dequeue cell with identifier: \(identifier)")
        }

        return cell
    }
}
