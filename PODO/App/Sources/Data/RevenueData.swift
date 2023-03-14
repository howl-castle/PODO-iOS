//
//  RevenueData.swift
//  PODO
//
//  Created by Ethan on 2023/03/14.
//

import Foundation

typealias RevenueArticleData = RevenueData.ArticleRevenueData
typealias RevenueAnswerData = RevenueData.AnswerRevenueData

struct RevenueData: Decodable {

    let totalBalance: Double?
    let article: ArticleRevenueData?
    let answer: AnswerRevenueData?
}

extension RevenueData {

    struct ArticleRevenueData: Decodable {
        let writing: Double?
        let translate: Double?
        let contribute: Double?
    }

    struct AnswerRevenueData: Decodable {
        let dora: Double?
        let myAnswer: Int?
        let adoptedAnswer: Int?
        let myQuestion: Int?
    }
}

// MARK: mock
extension RevenueData {

    static let mock = RevenueData(totalBalance: 150,
                                  article: .mock,
                                  answer: .mock)
}

extension RevenueArticleData {

    static let mock = RevenueArticleData(writing: 10,
                                         translate: 20,
                                         contribute: 8)
}

extension RevenueAnswerData {

    static let mock = RevenueAnswerData(dora: 12,
                                        myAnswer: 80,
                                        adoptedAnswer: 10,
                                        myQuestion: 5)
}
