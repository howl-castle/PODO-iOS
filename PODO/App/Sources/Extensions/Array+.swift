//
//  Array+.swift
//  PODO
//
//  Created by Yun on 2023/03/04.
//

import Foundation

extension Array {

    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
