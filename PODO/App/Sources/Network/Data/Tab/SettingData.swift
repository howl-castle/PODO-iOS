//
//  SettingData.swift
//  PODO
//
//  Created by Yun on 2023/03/17.
//

import Foundation

struct SettingData: Decodable {
    let user: UserData?
    let writing: [ArticleData]?
    let subscribe: [UserData]?
    let save: [ArticleData]?
    let usePrimLanguage: Bool?
}

// Mock
extension SettingData {

    static let mock = SettingData(user: .myMock,
                                  writing: ArticleData.hottestMocks,
                                  subscribe: nil,
                                  save: ArticleData.insightMocks,
                                  usePrimLanguage: false)
}
