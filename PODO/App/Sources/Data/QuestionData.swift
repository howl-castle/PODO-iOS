//
//  QuestionData.swift
//  PODO
//
//  Created by Ethan on 2023/03/11.
//

import Foundation

struct QuestionData: Decodable {
    let title: String?
    let content: String?
    // TODO: 시간 폼 만들기
    let createdAt: String?
    let commentCount: Int?
    let viewCount: Int?
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
                                    user: .myMock,
                                    interests: InterestData.mocks,
                                    answers: [.mock1])

    static let mock2 = QuestionData(title: "음식점에서 배달음식을 시켜 먹을 수 있다??????????????????????????????????????",
                                    content: "중국집에서 냉면을 시켜 먹고, 일식집에서 짜장면을 시켜먹을 수 있을까요??????????????????????????????????????????????????",
                                    createdAt: "1 days ago",
                                    commentCount: 21,
                                    viewCount: 100,
                                    user: .myMock,
                                    interests: InterestData.mocks,
                                    answers: [.mock1])

    static let mock3 = QuestionData(title: "바나나를 정확히 3등분 하는 방법이 있을까요?",
                                    content: "바나나를 정확히 3등분 하는 방법이 있을까요?바나나를 정확히 3등분 하는 방법이 있을까요?바나나를 정확히 3등분 하는 방법이 있을까요?바나나를 정확히 3등분 하는 방법이 있을까요?바나나를 정확히 3등분 하는 방법이 있을까요?바나나를 정확히 3등분 하는 방법이 있을까요?",
                                    createdAt: "1 hours ago",
                                    commentCount: 1,
                                    viewCount: 13,
                                    user: .mock1,
                                    interests: InterestData.mocks,
                                    answers: [.mock1])

    static let mock4 = QuestionData(title: "있다!? 없다!?",
                                    content: "냉무",
                                    createdAt: "11 hours ago",
                                    commentCount: 11,
                                    viewCount: 130,
                                    user: .mock1,
                                    interests: InterestData.mocks,
                                    answers: [.mock1])

    static let mocks: [QuestionData] = [.mock3, .mock4, .mock3]
    static let myMocks: [QuestionData] = [.mock1, .mock1, .mock2]
}

extension QuestionData.AnswerData {

    static let mock1 = QuestionData.AnswerData(content: "냉무",
                                               createdAt: "11 hours ago",
                                               isAdopted: false,
                                               user: .mock1)
}
