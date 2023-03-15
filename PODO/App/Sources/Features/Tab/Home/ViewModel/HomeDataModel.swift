//
//  HomeDataModel.swift
//  PODO
//
//  Created by Ethan on 2023/03/11.
//

import Foundation

struct HomeDataModel {
    // 엔티티를 그냥 들고 있을 지, 아니면 한번 감싸서 들고 있을 지..
    private(set) var data: HomeData?
    private(set) var categories: [String] = InterestData.mocks.compactMap({ $0.title })
    private(set) var selectedCategory: Int = .zero

    var insightArticles: [ArticleData] {
        if self.selectedCategory == .zero {
            return self.data?.insightArticles ?? []
        } else {
            return self.data?.insightArticles?.filter {
                $0.category == self.categories[safe: self.selectedCategory]
            } ?? []
        }
    }

    init() {
        self.data = .mock
    }

    mutating func updateSelectedCategory(_ category: Int) {
        self.selectedCategory = category
    }
}
