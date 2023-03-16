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
                                    interests: InterestData.mock1,
                                    answers: [.mock1])

    static let mock2 = QuestionData(title: "음식점에서 배달음식을 시켜 먹을 수 있다??????????????????????????????????????",
                                    content: "중국집에서 냉면을 시켜 먹고, 일식집에서 짜장면을 시켜먹을 수 있을까요??????????????????????????????????????????????????",
                                    createdAt: "1 days ago",
                                    commentCount: 21,
                                    viewCount: 100,
                                    cost: 100.0,
                                    user: .qMock2,
                                    interests: InterestData.mock2,
                                    answers: [.mock1])

    static let mock3 = QuestionData(title: "바나나를 정확히 3등분 하는 방법이 있을까요?",
                                    content: "바나나를 정확히 3등분 하는 방법이 있을까요?바나나를 정확히 3등분 하는 방법이 있을까요?바나나를 정확히 3등분 하는 방법이 있을까요?바나나를 정확히 3등분 하는 방법이 있을까요?바나나를 정확히 3등분 하는 방법이 있을까요?바나나를 정확히 3등분 하는 방법이 있을까요?",
                                    createdAt: "1 hours ago",
                                    commentCount: 1,
                                    viewCount: 13,
                                    cost: 100.0,
                                    user: .qMock3,
                                    interests: InterestData.mock3,
                                    answers: [.mock1])

    static let mock4 = QuestionData(title: "있다!? 없다!?",
                                    content: "냉무",
                                    createdAt: "11 hours ago",
                                    commentCount: 11,
                                    viewCount: 130,
                                    cost: 100.0,
                                    user: .mock1,
                                    interests: InterestData.mock4,
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

    static let trendingMock2 = QuestionAnswerData(content: "The reason why iOS 14 does not display the Wallet feature for the following reasons: First,",
                                                  createdAt: "1 hours ago",
                                                  isAdopted: false,
                                                  user: .userMock3)

    static let trendingMock3 = QuestionAnswerData(content: "Have you ever heard of copilot? If you get used to the tool called copilot,",
                                                  createdAt: "1 hours ago",
                                                  isAdopted: false,
                                                  user: .userMock3)

    static let trendingMock4 = QuestionAnswerData(content: "A user experience researcher has their hand on the pulse of user needs and goals. They are the empathetic, organized, critical thinker whose day-to-day is about the first stage of the design thinking process: empathize.",
                                                  createdAt: "1 hours ago",
                                                  isAdopted: false,
                                                  user: .userMock3)

    static let interestMock1 = QuestionAnswerData(content: "To use ChatGPT to select the right query when writing a report,",
                                                  createdAt: "1 hours ago",
                                                  isAdopted: false,
                                                  user: .userMock2)

    static let interestMock2 = QuestionAnswerData(content: "The year 2023 will mark a turning point for businesses looking to implement blockchain technology, thanks to the growing availability of blockchain-as-a-service (BaaS) solutions.",
                                                  createdAt: "1 hours ago",
                                                  isAdopted: false,
                                                  user: .userMock2)

    static let interestMock3 = QuestionAnswerData(content: "What will the much-hyped technology mean for developers, creatives, and UX designers? Answer...",
                                                  createdAt: "1 hours ago",
                                                  isAdopted: false,
                                                  user: .userMock2)

    static let interestMock4 = QuestionAnswerData(content: "The classifier I used was a built-in model of OpenCV located within the HaarCascades. These...",
                                                  createdAt: "1 hours ago",
                                                  isAdopted: false,
                                                  user: .userMock3)
}

extension QuestionData {

    static let trendingMocks: [QuestionData] = [.trendingMock1, .trendingMock2, .trendingMock3, .trendingMock4]
    static let interestMocks: [QuestionData] = [.interestMock1, .interestMock2, .interestMock3, .interestMock4]

    static let trendingMock1 = QuestionData(
        title: "Can ART NFT Overcome the Crypto Winter?",
        content: "I would like to introduce two NFT projects that are slightly different from Opensea. Unlike...",
        createdAt: "11 hours ago",
        commentCount: 11,
        viewCount: 130,
        cost: 15.0,
        user: .qMock1,
        interests: InterestData.mock2,
        answers: [.trendingMock1]
    )

    static let trendingMock2 = QuestionData(
        title: "Why doesn't iOS 14 support the wallet feature?",
        content: "I would like to introduce two NFT projects that are slightly different from Opensea. Unlike...",
        createdAt: "3 min ago",
        commentCount: 11,
        viewCount: 130,
        cost: 15.0,
        user: .userMock1,
        interests: InterestData.mock2,
        answers: [.trendingMock2]
    )

    static let trendingMock3 = QuestionData(
        title: "How to use ChatGPT for iOS development",
        content: "I would like to introduce two NFT projects that are slightly different from Opensea. Unlike...",
        createdAt: "48 min ago",
        commentCount: 11,
        viewCount: 130,
        cost: 15.0,
        user: .nowMock1,
        interests: InterestData.mock2,
        answers: [.trendingMock3]
    )

    static let trendingMock4 = QuestionData(
        title: "UX Researcher Career Guide",
        content: "I would like to introduce two NFT projects that are slightly different from Opensea. Unlike...",
        createdAt: "48 min ago",
        commentCount: 11,
        viewCount: 130,
        cost: 15.0,
        user: .nowMock2,
        interests: InterestData.mock2,
        answers: [.trendingMock4]
    )

    static let interestMock1 = QuestionData(
        title: "Query selection for ChatGPT",
        content: "What are some real-world blockchain use cases?",
        createdAt: "1 hours ago",
        commentCount: 9,
        viewCount: 56,
        cost: 30.0,
        user: .qMock2,
        interests: InterestData.mock1,
        answers: [.interestMock1]
    )

    static let interestMock2 = QuestionData(
        title: "Web3.0 Tredning Topic 2023",
        content: "What are some real-world blockchain use cases?",
        createdAt: "1 hours ago",
        commentCount: 13,
        viewCount: 34,
        cost: 25.0,
        user: .contentMock1,
        interests: InterestData.mock1,
        answers: [.interestMock2]
    )

    static let interestMock3 = QuestionData(
        title: "What are some real-world blockchain use cases?",
        content: "What are some real-world blockchain use cases?",
        createdAt: "1 hours ago",
        commentCount: 11,
        viewCount: 56,
        cost: 22.0,
        user: .qMock2,
        interests: InterestData.mock1,
        answers: [.interestMock3]
    )

    static let interestMock4 = QuestionData(
        title: "Explaining the Real-Time Facial Recognition with Python",
        content: "Explaining the Real-Time Facial Recognition with Python",
        createdAt: "1 hours ago",
        commentCount: 11,
        viewCount: 35,
        cost: 32.0,
        user: .userMock3,
        interests: InterestData.mock4,
        answers: [.interestMock4]
    )

}
