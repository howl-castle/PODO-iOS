//
//  QuestionData.swift
//  PODO
//
//  Created by Ethan on 2023/03/11.
//

import Foundation

typealias QuestionAnswerData = QuestionData.AnswerData

struct QuestionData: Decodable {
    // 서버에 추가 요청 필요.
    let id: Int?

    let title: String?              // qa_title ==> title
    let content: String?            // qa_contents ==> content
    let interests: [InterestData]?  // hashtags ==> interests
    let dora: Double?

    // TODO: 시간 폼 만들기
    let createdAt: String?          // datetime ==> createdAt

    let commentCount: Int?          // comm_contents ==> commentCount
    let viewCount: Int?             // hits_num ==> viewCount

    // 서버에 추가 요청 필요.
    let user: UserData?
    let answers: [AnswerData]?
}

extension QuestionData {

    struct AnswerData: Decodable {
        let id: Int?
        let content: String?        // comm_contents ==> content
        let createdAt: String?      // datetime ==> createdAt
        let isAdopted: Bool?

        // 서버에 추가 요청 필요.
        let user: UserData?
    }
}

// MARK: - Mock
extension QuestionData {

    static let mock1 = QuestionData(id: 1,
                                    title: "달리는 버스에서 짜장면을 시킬 수 있다?",
                                    content: "냉무",
                                    interests: InterestData.mock1,
                                    dora: 100.0,
                                    createdAt: "1 minute ago",
                                    commentCount: 5,
                                    viewCount: 23,
                                    user: .qMock1,
                                    answers: [.mock1])

    static let mock2 = QuestionData(id: 1,
                                    title: "음식점에서 배달음식을 시켜 먹을 수 있다??????????????????????????????????????",
                                    content: "중국집에서 냉면을 시켜 먹고, 일식집에서 짜장면을 시켜먹을 수 있을까요??????????????????????????????????????????????????",
                                    interests: InterestData.mock2,
                                    dora: 100.0,
                                    createdAt: "1 days ago",
                                    commentCount: 21,
                                    viewCount: 100,
                                    user: .qMock2,
                                    answers: [.mock1])

    static let mock3 = QuestionData(id: 1,
                                    title: "바나나를 정확히 3등분 하는 방법이 있을까요?",
                                    content: "바나나를 정확히 3등분 하는 방법이 있을까요?바나나를 정확히 3등분 하는 방법이 있을까요?바나나를 정확히 3등분 하는 방법이 있을까요?바나나를 정확히 3등분 하는 방법이 있을까요?바나나를 정확히 3등분 하는 방법이 있을까요?바나나를 정확히 3등분 하는 방법이 있을까요?",
                                    interests: InterestData.mock3,
                                    dora: 100.0,
                                    createdAt: "1 hours ago",
                                    commentCount: 1,
                                    viewCount: 13,
                                    user: .qMock3,
                                    answers: [.mock1])

    static let mock4 = QuestionData(id: 1,
                                    title: "있다!? 없다!?",
                                    content: "냉무",
                                    interests: InterestData.mock4,
                                    dora: 100.0,
                                    createdAt: "11 hours ago",
                                    commentCount: 11,
                                    viewCount: 130,
                                    user: .mock1,
                                    answers: [.mock1])

    static let mocks: [QuestionData] = [.mock3, .mock4, .mock3]
    static let myMocks: [QuestionData] = [.mock1, .mock1, .mock2]
}

extension QuestionAnswerData {
    
    static let mock1 = QuestionAnswerData(id: 1,
                                          content: "냉무",
                                          createdAt: "11 hours ago",
                                          isAdopted: false,
                                          user: .mock1)

    static let trendingMock1 = QuestionAnswerData(id: 1,
                                                  content: "I would like to introduce two NFT projects that are slightly different from Opensea. Unlike...",
                                                  createdAt: "1 hours ago",
                                                  isAdopted: false,
                                                  user: .userMock1)

    static let trendingMock2 = QuestionAnswerData(id: 1,
                                                  content: "The reason why iOS 14 does not display the Wallet feature for the following reasons: First,",
                                                  createdAt: "1 hours ago",
                                                  isAdopted: false,
                                                  user: .userMock3)

    static let trendingMock3 = QuestionAnswerData(id: 1,
                                                  content: "Have you ever heard of copilot? If you get used to the tool called copilot,",
                                                  createdAt: "1 hours ago",
                                                  isAdopted: false,
                                                  user: .userMock3)

    static let trendingMock4 = QuestionAnswerData(id: 1,
                                                  content: "A user experience researcher has their hand on the pulse of user needs and goals. They are the empathetic, organized, critical thinker whose day-to-day is about the first stage of the design thinking process: empathize.",
                                                  createdAt: "1 hours ago",
                                                  isAdopted: false,
                                                  user: .userMock3)

    static let interestMock1 = QuestionAnswerData(id: 1,
                                                  content: "To use ChatGPT to select the right query when writing a report,",
                                                  createdAt: "1 hours ago",
                                                  isAdopted: false,
                                                  user: .userMock2)

    static let interestMock2 = QuestionAnswerData(id: 1,
                                                  content: "The year 2023 will mark a turning point for businesses looking to implement blockchain technology, thanks to the growing availability of blockchain-as-a-service (BaaS) solutions.",
                                                  createdAt: "1 hours ago",
                                                  isAdopted: false,
                                                  user: .userMock2)

    static let interestMock3 = QuestionAnswerData(id: 1,
                                                  content: "What will the much-hyped technology mean for developers, creatives, and UX designers? Answer...",
                                                  createdAt: "1 hours ago",
                                                  isAdopted: false,
                                                  user: .userMock2)

    static let interestMock4 = QuestionAnswerData(id: 1,
                                                  content: "The classifier I used was a built-in model of OpenCV located within the HaarCascades. These...",
                                                  createdAt: "1 hours ago",
                                                  isAdopted: false,
                                                  user: .userMock3)
}

extension QuestionData {

    static let trendingMocks: [QuestionData] = [.trendingMock1, .trendingMock2, .trendingMock3, .trendingMock4]
    static let interestMocks: [QuestionData] = [.interestMock1, .interestMock2, .interestMock3, .interestMock4]

    static let trendingMock1 = QuestionData(
        id: 1,
        title: "Can ART NFT Overcome the Crypto Winter?",
        content: "I would like to introduce two NFT projects that are slightly different from Opensea. Unlike...",
        interests: InterestData.mock2,
        dora: 15.0,
        createdAt: "11 hours ago",
        commentCount: 11,
        viewCount: 130,
        user: .qMock1,
        answers: [.trendingMock1]
    )

    static let trendingMock2 = QuestionData(
        id: 1,
        title: "Why doesn't iOS 14 support the wallet feature?",
        content: "I would like to introduce two NFT projects that are slightly different from Opensea. Unlike...",
        interests: InterestData.mock2,
        dora: 15.0,
        createdAt: "3 min ago",
        commentCount: 11,
        viewCount: 130,
        user: .userMock1,
        answers: [.trendingMock2]
    )

    static let trendingMock3 = QuestionData(
        id: 1,
        title: "How to use ChatGPT for iOS development",
        content: "I would like to introduce two NFT projects that are slightly different from Opensea. Unlike...",
        interests: InterestData.mock2,
        dora: 15.0,
        createdAt: "48 min ago",
        commentCount: 11,
        viewCount: 130,
        user: .nowMock1,
        answers: [.trendingMock3]
    )

    static let trendingMock4 = QuestionData(
        id: 1,
        title: "UX Researcher Career Guide",
        content: "I would like to introduce two NFT projects that are slightly different from Opensea. Unlike...",
        interests: InterestData.mock2,
        dora: 15.0,
        createdAt: "48 min ago",
        commentCount: 11,
        viewCount: 130,
        user: .nowMock2,
        answers: [.trendingMock4]
    )

    static let interestMock1 = QuestionData(
        id: 1,
        title: "Query selection for ChatGPT",
        content: "What are some real-world blockchain use cases?",
        interests: InterestData.mock1,
        dora: 30.0,
        createdAt: "1 hours ago",
        commentCount: 9,
        viewCount: 56,
        user: .qMock2,
        answers: [.interestMock1]
    )

    static let interestMock2 = QuestionData(
        id: 1,
        title: "Web3.0 Tredning Topic 2023",
        content: "What are some real-world blockchain use cases?",
        interests: InterestData.mock1,
        dora: 25.0,
        createdAt: "1 hours ago",
        commentCount: 13,
        viewCount: 34,
        user: .contentMock1,
        answers: [.interestMock2]
    )

    static let interestMock3 = QuestionData(
        id: 1,
        title: "What are some real-world blockchain use cases?",
        content: "What are some real-world blockchain use cases?",
        interests: InterestData.mock1,
        dora: 22.0,
        createdAt: "1 hours ago",
        commentCount: 11,
        viewCount: 56,
        user: .qMock2,
        answers: [.interestMock3]
    )

    static let interestMock4 = QuestionData(
        id: 1,
        title: "Explaining the Real-Time Facial Recognition with Python",
        content: "Explaining the Real-Time Facial Recognition with Python",
        interests: InterestData.mock4,
        dora: 32.0,
        createdAt: "1 hours ago",
        commentCount: 11,
        viewCount: 35,
        user: .userMock3,
        answers: [.interestMock4]
    )

}
