//
//  HomeData.swift
//  PODO
//
//  Created by Ethan on 2023/03/11.
//

import Foundation

struct HomeData: Decodable {
    let newArticles: [ArticleData]?
    let hottestArticles: [ArticleData]?
    let insightArticles: [ArticleData]?
}

// MARK: - Mock
extension HomeData {

    static let mock = HomeData(newArticles: ArticleData.hottestMocks,
                               hottestArticles: ArticleData.hottestMocks,
                               insightArticles: ArticleData.mocks)
}
