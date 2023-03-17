//
//  SettingDataModel.swift
//  PODO
//
//  Created by Yun on 2023/03/17.
//

import Foundation

struct SettingDataModel {
    // 엔티티를 그냥 들고 있을 지, 아니면 한번 감싸서 들고 있을 지..
    private(set) var data: SettingData?

    init() {
        //
        self.data = .mock
    }
}
