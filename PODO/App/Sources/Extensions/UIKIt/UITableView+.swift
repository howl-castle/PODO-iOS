//
//  UITableView+.swift
//  PODO
//
//  Created by Yun on 2023/03/04.
//

import UIKit

extension UITableView {

    func dequeueReusableCell<T: UITableViewCell>(_ cell: T.Type, for indexPath: IndexPath) -> T? {
        self.dequeueReusableCell(withIdentifier: String(describing: cell), for: indexPath) as? T
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ view: T.Type) -> T? {
        self.dequeueReusableHeaderFooterView(withIdentifier: String(describing: view)) as? T
    }

    func register<T: UITableViewCell>(cell: T.Type) {
        self.register(cell, forCellReuseIdentifier: String(describing: cell))
    }

    func register<T: UITableViewHeaderFooterView>(headerFooterView: T.Type) {
        self.register(headerFooterView,
                      forHeaderFooterViewReuseIdentifier: String(describing: headerFooterView))
    }
}
