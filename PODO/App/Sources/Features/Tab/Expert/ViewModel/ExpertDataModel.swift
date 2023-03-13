//
//  ExpertDataModel.swift
//  PODO
//
//  Created by Ethan on 2023/03/11.
//

import Foundation

struct ExpertDataModel {
    // 엔티티를 그냥 들고 있을 지, 아니면 한번 감싸서 들고 있을 지..
    private(set) var data: ExpertData?

    init() {
        // API 호출 후
        self.data = .mock
    }
}
