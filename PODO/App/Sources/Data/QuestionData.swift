//
//  QuestionData.swift
//  PODO
//
//  Created by Ethan on 2023/03/11.
//

import Foundation

typealias QuestionAnswerData = QuestionData.AnswerData

struct QuestionData: Decodable {
    let title: String?
    let content: String?
    // TODO: 시간 폼 만들기
    let createdAt: String?
    let commentCount: Int?
    let viewCount: Int?
    let cost: Double?
    let user: UserData?
    let interests: [InterestData]?
    let answers: [AnswerData]?
}

extension QuestionData {

    struct AnswerData: Decodable {
        let content: String?
        let createdAt: String?
        let isAdopted: Bool?
        let user: UserData?
    }
}

// MARK: - Mock
extension QuestionData {

    static let mock1 = QuestionData(title: "달리는 버스에서 짜장면을 시킬 수 있다?",
                                    content: "냉무",
                                    createdAt: "1 minute ago",
                                    commentCount: 5,
                                    viewCount: 23,
                                    cost: 100.0,
                                    user: .qMock1,
                                    interests: InterestData.mocks,
                                    answers: [.mock1])

    static let mock2 = QuestionData(title: "음식점에서 배달음식을 시켜 먹을 수 있다??????????????????????????????????????",
                                    content: "중국집에서 냉면을 시켜 먹고, 일식집에서 짜장면을 시켜먹을 수 있을까요??????????????????????????????????????????????????",
                                    createdAt: "1 days ago",
                                    commentCount: 21,
                                    viewCount: 100,
                                    cost: 100.0,
                                    user: .qMock2,
                                    interests: InterestData.mocks,
                                    answers: [.mock1])

    static let mock3 = QuestionData(title: "바나나를 정확히 3등분 하는 방법이 있을까요?",
                                    content: "바나나를 정확히 3등분 하는 방법이 있을까요?바나나를 정확히 3등분 하는 방법이 있을까요?바나나를 정확히 3등분 하는 방법이 있을까요?바나나를 정확히 3등분 하는 방법이 있을까요?바나나를 정확히 3등분 하는 방법이 있을까요?바나나를 정확히 3등분 하는 방법이 있을까요?",
                                    createdAt: "1 hours ago",
                                    commentCount: 1,
                                    viewCount: 13,
                                    cost: 100.0,
                                    user: .qMock3,
                                    interests: InterestData.mocks,
                                    answers: [.mock1])

    static let mock4 = QuestionData(title: "있다!? 없다!?",
                                    content: "냉무",
                                    createdAt: "11 hours ago",
                                    commentCount: 11,
                                    viewCount: 130,
                                    cost: 100.0,
                                    user: .mock1,
                                    interests: InterestData.mocks,
                                    answers: [.mock1])

    static let mocks: [QuestionData] = [.mock3, .mock4, .mock3]
    static let myMocks: [QuestionData] = [.mock1, .mock1, .mock2]
}

extension QuestionAnswerData {
    
    static let mock1 = QuestionAnswerData(content: "냉무",
                                          createdAt: "11 hours ago",
                                          isAdopted: false,
                                          user: .mock1)

    static let trendingMock1 = QuestionAnswerData(content: "I would like to introduce two NFT projects that are slightly different from Opensea. Unlike...",
                                                  createdAt: "1 hours ago",
                                                  isAdopted: false,
                                                  user: .userMock1)

    static let interestMock1 = QuestionAnswerData(content: "What will the much-hyped technology mean for developers, creatives, and UX designers? Answer...",
                                                  createdAt: "1 hours ago",
                                                  isAdopted: false,
                                                  user: .userMock2)

    static let interestMock2 = QuestionAnswerData(content: "The classifier I used was a built-in model of OpenCV located within the HaarCascades. These...",
                                                  createdAt: "1 hours ago",
                                                  isAdopted: false,
                                                  user: .userMock3)
}

extension QuestionData {

    static let trendingMocks: [QuestionData] = [.trendingMock1, .trendingMock1]
    static let interestMocks: [QuestionData] = [.interestMock1, .interestMock2]

    static let trendingMock1 = QuestionData(
        title: " Can ART NFT Overcome the Crypto Winter?",
        content: "I would like to introduce two NFT projects that are slightly different from Opensea. Unlike...",
        createdAt: "11 hours ago",
        commentCount: 11,
        viewCount: 130,
        cost: 15.0,
        user: .qMock1,
        interests: InterestData.mocks,
        answers: [.trendingMock1]
    )

    static let interestMock1 = QuestionData(
        title: "What are some real-world blockchain use cases?",
        content: "What are some real-world blockchain use cases?",
        createdAt: "1 hours ago",
        commentCount: 11,
        viewCount: 130,
        cost: 10.0,
        user: .qMock2,
        interests: InterestData.mocks,
        answers: [.interestMock1]
    )

    static let interestMock2 = QuestionData(
        title: "Explaining the Real-Time Facial Recognition with Python",
        content: "Explaining the Real-Time Facial Recognition with Python",
        createdAt: "1 hours ago",
        commentCount: 11,
        viewCount: 130,
        cost: 20.0,
        user: .qMock2,
        interests: InterestData.mocks,
        answers: [.interestMock2]
    )

}
