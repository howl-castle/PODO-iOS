//
//  UICollectionView+.swift
//  PODO
//
//  Created by Yun on 2023/03/04.
//

import UIKit

extension UICollectionView {

    func dequeueReusableCell<T: UICollectionViewCell>(_ cell: T.Type, for indexPath: IndexPath) -> T? {
        self.dequeueReusableCell(withReuseIdentifier: String(describing: cell), for: indexPath) as? T
    }

    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(_ view: T.Type, ofKind kind: String, for indexPath: IndexPath) -> T? {
        self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: view), for: indexPath) as? T
    }

    func register<T: UICollectionViewCell>(cell: T.Type) {
        self.register(cell, forCellWithReuseIdentifier: String(describing: cell))
    }

    func register<T: UICollectionReusableView>(reusableView: T.Type, kind: String) {
        self.register(reusableView,
                      forSupplementaryViewOfKind: kind,
                      withReuseIdentifier: String(describing: reusableView))
    }
}
