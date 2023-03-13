//
//  UIImageView+.swift
//  PODO
//
//  Created by Ethan on 2023/03/11.
//

import UIKit

extension UIImageView {

    func updateImageTintColor(_ color: UIColor?) {
        let image = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = image
        self.tintColor = color
    }
}
