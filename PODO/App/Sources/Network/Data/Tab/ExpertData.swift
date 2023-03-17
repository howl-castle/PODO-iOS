//
//  ExpertData.swift
//  PODO
//
//  Created by Ethan on 2023/03/11.
//

import Foundation

struct ExpertData: Decodable {
    let myQuestion: [QuestionData]?
    let trendingQuestion: [QuestionData]?
    let recommendQuestion: [QuestionData]?
}

// MARK: - Mock
extension ExpertData {

    static let mock = ExpertData(myQuestion: [],
                                 trendingQuestion: QuestionData.trendingMocks,
                                 recommendQuestion: QuestionData.interestMocks)
}
