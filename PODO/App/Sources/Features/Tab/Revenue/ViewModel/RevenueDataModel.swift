//
//  RevenueDataModel.swift
//  PODO
//
//  Created by Yun on 2023/03/17.
//

import Foundation

struct RevenueDataModel {
    // 엔티티를 그냥 들고 있을 지, 아니면 한번 감싸서 들고 있을 지..
    let data: RevenueData

    init(data: RevenueData) {
        self.data = data
    }
}
