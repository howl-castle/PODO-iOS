//
//  ArticleData.swift
//  PODO
//
//  Created by Ethan on 2023/03/11.
//

import Foundation

struct ArticleData: Decodable {
    let id: Int?
    let title: String?
    let summary: String?
    let imageUrls: [String]?

    // 서버에 추가 요청
    let contents: [String]?
    let image: String?
    let category: String?
    let isBookmarked: Bool?
    let createdAt: String?          // datetime ==> createdAt
    let author: UserData?           // author_name: String ==> author: UserData
    let translator: UserData?
    let contributors: [UserData]?

    // 제거 필요.
    var images: [String]?
    var thumbail: String?
}

// MARK: - Mock
extension ArticleData {

    static let mock1 = ArticleData(id: 1,
                                   title: "행운의 편지",
                                   summary: "이 편지는 영국에서 최초로 시작되어 일년에 한바퀴를 돌면서 받는 사람에게 행운을 주었고...",
                                   imageUrls: Self.imagePaths,
                                   contents: Self.contents,
                                   image: "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Ft1.daumcdn.net%2Fcfile%2Ftistory%2F222FEF3751E8AFD429",
                                   category: "Coin",
                                   isBookmarked: true,
                                   createdAt: "1 hours ago",
                                   author: .mock1,
                                   translator: .mock1,
                                   contributors: [.mock1])

    static let mock2 = ArticleData(id: 1,
                                   title: "Rise of Stars(ROS) Silthereum Burn",
                                   summary: "행운",
                                   imageUrls: Self.imagePaths,
                                   contents: Self.contents,
                                   image: "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Ft1.daumcdn.net%2Fcfile%2Ftistory%2F222FEF3751E8AFD429",
                                   category: "Design",
                                   isBookmarked: false,
                                   createdAt: "1 hours ago",
                                   author: .myMock,
                                   translator: .mock1,
                                   contributors: nil)

    static let mock3 = ArticleData(id: 1,
                                   title: "Rise of Stars(ROS) Silthereum Burn",
                                   summary: "이 편지는 영국에서 최초로 시작되어 일년에 한바퀴를 돌면서 받는 사람에게 행운을 주었고...",
                                   imageUrls: Self.imagePaths,
                                   contents: Self.contents,
                                   image: "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Ft1.daumcdn.net%2Fcfile%2Ftistory%2F222FEF3751E8AFD429",
                                   category: "TON",
                                   isBookmarked: false,
                                   createdAt: "1 hours ago",
                                   author: .mock1,
                                   translator: nil,
                                   contributors: [.mock1])

    static let mocks: [ArticleData] = [.mock1, .mock2, .mock3]

    private static let imagePaths: [String] = [
        "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Ft1.daumcdn.net%2Fcfile%2Ftistory%2F222FEF3751E8AFD429",
        "https://thumbnews.nateimg.co.kr/view610///news.nateimg.co.kr/orgImg/mw/2021/02/25/2021022511308005742_1.jpg",
        "https://spnimage.edaily.co.kr/images/photo/files/NP/S/2022/10/PS22102400062.jpg",
        "https://cdn.sports.hankooki.com/news/photo/202111/img_6754646_0.jpg",
        "https://thumb.mt.co.kr/06/2019/12/2019121110584743109_1.jpg/dims/optimize/"
    ]

    private static let contents1: [String] = [
"""
한국 야구 대표팀이 2023 월드베이스볼클래식(WBC)에서 8강 진출에 실패하며 1라운드에서 탈락했다. 2013년 대회, 2017년 대회에 이어 6년 만에 열린 2023 대회에서도 1라운드에서 짐을 쌌다.
""",
"""
한국은 13일 저녁 7시 일본 도쿄의 도쿄돔에서 월드베이스볼클래식(WBC) 1라운드 B조 중국과 조별리그 마지막 경기를 갖게 된다.
""",
"""
그러나 앞서 열린 경기에서 호주가 체코를 꺾고 3승 1패, 일본(4승)에 이어 조 2위를 확정하며 나머지 한 장의 8강 티켓을 차지했다. 한국은 중국에 승리해도 2승2패에 그친다.
""",
"""
14년 만에 WBC 4강 진출을 목표로 했던 한국의 꿈은 산산조각이 났다. 한국은 반드시 잡았어야 할 호주와의 경기에서 7-8로 역전패 한 것이 치명타가 됐다.
""",
"""
이강철 감독은 중국과의 경기 전 공식 기자회견에 참가해 8강 탈락에 대해 착잡한 심정은 경기 후에 언급하겠다고 미뤘다. 일단 중국전에 집중하겠다는 뜻이었다. 다음은 일문일답.
""",
"""
-오늘 경기 임하는 각오는.
""",
"""
최선을 다해서 이길 수 있도록 하겠다.
""",
"""
-호주와 체코 경기 결과에 따라 1라운드 탈락이 결정됐는데, 지금 심경은 어떤지.
""",
"""
마음이 좋지 않지만, 경기는 해야 한다. (중국전) 경기 끝나고 심정은 말씀 드리겠다.
""",
"""
-오늘 스타팅 라인업 변화는 있는지.
""",
"""
몸이 좀 안 좋은 선수들이 있다. (그동안) 못 나간 선수들도 있었고, 초반 중국 선발이 빠른볼 투수라 그것에 대처 능력이 좋은 선수로 꾸렸다.
""",
"""
한편 이후 경기 1시간 전에 공개된 선발 라인업은 박해민(1루수) 김혜성(2루수) 이정후(중견수) 김하성(3루수) 강백호(지명타자) 박건우(우익수) 오지환(유격수) 이지영(포수) 최지훈(좌익수)이 출장한다. 앞서 3경기에 많이 뛰지 못한 선수들이 대거 선발 출장한다.
"""
    ]

    private static let contents: [String] = [
"""
Contrary to popular belief, Lorem Ipsum is not simply random text.
""",
"""
It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.
""",
"""
Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.
""",
"""
 Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC.
""",
"""
 This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.
""",
"""
The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested.
""",
"""
Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.
""",
"""
Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.
""",
"""
"Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.
""",
"""
Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC.
""",
"""
This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.
""",
"""
The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested.
""",
"""
Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.
"""
    ]
}

// Now
extension ArticleData {

    static let nowMocks: [ArticleData] = [.nowMock1, .nowMock2]

    static let nowMock1 = ArticleData(
        id: 1,
        title: "UI/UX Design Trends 2023",
        summary: "Highlighting some of the trends weAr think will persist and perhaps gain even more traction in the next year.",
        imageUrls: nil,
        contents: Self.hotContentMock1,
        image: "https://miro.medium.com/v2/resize:fit:1400/format:webp/1*jOYBHA_PnToXKbupkBdI1w.png",
        category: "TON",
        isBookmarked: false,
        createdAt: "Mar 23. 2023",
        author: .nowMock1,
        translator: .userMock1,
        contributors: [.qMock1, .userMock2],
        images: ["HottestImage1", "hot2"]
    )

    static let nowMock2 = ArticleData(
        id: 1,
        title: "3 ChatGPT Extensions to Automate Your Life",
        summary: "ChatGPT on WhatsApp, Gmail, Google Sheets, your code editor, and more!",
        imageUrls: nil,
        contents: Self.hotContentMock1,
        image: "https://miro.medium.com/v2/resize:fit:1400/format:webp/1*jBqAOsjmedJVHwGbyP5PTw.jpeg",
        category: "TON",
        isBookmarked: false,
        createdAt: "Mar 23. 2023",
        author: .nowMock2,
        translator: .userMock1,
        contributors: [.qMock1, .userMock2],
        images: ["HottestImage1", "hot2"]
    )
}


// Hottest
extension ArticleData {

    static let hottestMocks: [ArticleData] = [.hottestMock1, .hottestMock2, .hottestMock3]

    static let hottestMock1 = ArticleData(
        id: 1,
        title: "Playkey users will receive cashback in TON tokens",
        summary: "Playkey is now officially supporting blockchain platform Free TON, which uses Telegram Open Network (TON) protocol.",
        imageUrls: nil,
        contents: Self.hotContentMock1,
        image: nil,
        category: "TON",
        isBookmarked: false,
        createdAt: "Mar 23. 2023",
        author: .hottestMock1,
        translator: .userMock1,
        contributors: [.qMock1, .userMock2],
        images: ["HottestImage1", "hot2"],
        thumbail: "hot1")

    static let hottestMock2 = ArticleData(
        id: 1,
        title: "Advanced Web3 Tokenomics Design ...",
        summary: "It is critical to decouple speculators from ...",
        imageUrls: nil,
        contents: Self.contents,
        image: nil,
        category: "TON",
        isBookmarked: false,
        createdAt: "1 hours ago",
        author: .hottestMock2,
        translator: .userMock3,
        contributors: nil,
        images: ["hot2", "HottestImage1"],
        thumbail: "hot2")

    static let hottestMock3 = ArticleData(
        id: 1,
        title: "10 Predictions for Web3 and the Cryptoeconomy for 2022",
        summary: "There will be significant usability improvements in L1-L2 bridges",
        imageUrls: nil,
        contents: Self.hotContentMock1,
        image: "https://miro.medium.com/v2/resize:fit:1400/format:webp/1*xTDqHEzLmlE7uyV9HuB64w.jpeg",
        category: "Web3.0",
        isBookmarked: false,
        createdAt: "Mar 23. 2023",
        author: .qMock3,
        translator: .userMock1,
        contributors: [.qMock1, .userMock2],
        images: ["HottestImage1", "hot2"]
    )

    private static let hotContentMock1: [String] = [
    """
    Playkey is now officially supporting blockchain platform Free TON, which uses Telegram Open Network (TON) protocol. Players will be able to receive TON tokens and transfer them to their TON-wallets.
    """,
    """
    Players will receive 20% cashback for their game time purchases. The exchange rate is 1 TON = $0,5. Tokens will be added to the account automatically, afterwards users will be able to request a payout in their personal account page. These will be monthly payments.
    """,
    """
    The initiative aims to encourage user loyalty, while also popularizing TON Crystal cryptocurrency.
    """
    ]
}

// insight
extension ArticleData {

    static let insightMocks: [ArticleData] = [.insightMock1, .insightMock2, .insightMock3,
                                              .insightMock4, .insightMock5, .insightMock6]

    static let insightMock1 = ArticleData(
        id: 1,
        title: "How To Wake Up at 5 A.M. Every Day",
        summary: "An unconventional and compassionate guide to becoming an early bird",
        imageUrls: nil,
        contents: Self.hotContentMock1,
        image:  "https://miro.medium.com/v2/resize:fit:1400/format:webp/1*-Y9ozbNWSViiCmal1TT32w.jpeg",
        category: "Self-Improvement",
        isBookmarked: false,
        createdAt: "Mar 23. 2023",
        author: .userMock3,
        translator: .userMock1,
        contributors: [.qMock1, .userMock2],
        images: ["HottestImage1", "hot2"]
    )

    static let insightMock2 = ArticleData(
        id: 1,
        title: "How to use chatGPT for UI/UX design: 25 examples",
        summary: "The practical guide to include AI in your daily workflow",
        imageUrls: nil,
        contents: Self.hotContentMock1,
        image: "https://miro.medium.com/v2/resize:fit:1400/format:webp/1*HYotfqluDW7xCqogV7ZGwQ.png",
        category: "Design",
        isBookmarked: false,
        createdAt: "Mar 23. 2023",
        author: .userMock1,
        translator: .userMock3,
        contributors: [.qMock1, .userMock2],
        images: ["HottestImage1", "hot2"]
    )

    static let insightMock3 = ArticleData(
        id: 1,
        title: "How to Instantly Improve Your Memory by Arousing Your Brain",
        summary: "No repetition required, nudity highly encouraged.",
        imageUrls: nil,
        contents: Self.hotContentMock1,
        image: "https://miro.medium.com/v2/resize:fit:1400/format:webp/1*iEfh1p_quzPDy8Za2IrVRg.jpeg",
        category: "Self-Improvement",
        isBookmarked: false,
        createdAt: "Mar 23. 2023",
        author: .qMock2,
        translator: .userMock1,
        contributors: [.qMock1, .userMock2],
        images: ["HottestImage1", "hot2"]
    )

    static let insightMock4 = ArticleData(
        id: 1,
        title: "Why We Need Web 3.0",
        summary: "Ethereum co-founder Gavin Wood on why today’s internet is broken — and how we can do better next time around",
        imageUrls: nil,
        contents: Self.hotContentMock1,
        image: "https://miro.medium.com/v2/resize:fit:1400/format:webp/1*nxFBxOzzJD6fjj7mp5plPg.jpeg",
        category: "Web3.0",
        isBookmarked: false,
        createdAt: "Mar 23. 2023",
        author: .nowMock2,
        translator: .userMock1,
        contributors: [.qMock1, .userMock2],
        images: ["HottestImage1", "hot2"]
    )

    static let insightMock5 = ArticleData(
        id: 1,
        title: "10 Predictions for Web3 and the Cryptoeconomy for 2022",
        summary: "There will be significant usability improvements in L1-L2 bridges",
        imageUrls: nil,
        contents: Self.hotContentMock1,
        image: "https://miro.medium.com/v2/resize:fit:1400/format:webp/1*xTDqHEzLmlE7uyV9HuB64w.jpeg",
        category: "Web3.0",
        isBookmarked: false,
        createdAt: "Mar 23. 2023",
        author: .qMock3,
        translator: .userMock1,
        contributors: [.qMock1, .userMock2],
        images: ["HottestImage1", "hot2"]
    )

    static let insightMock6 = ArticleData(
        id: 1,
        title: "Zero to Hero: Web3.0 and Solidity Development Roadmap 2023",
        summary: "Learning Web3.0 and blockchain development today is like buying a Bitcoin at $10 yesterday.",
        imageUrls: nil,
        contents: Self.hotContentMock1,
        image: "https://miro.medium.com/v2/resize:fit:1400/format:webp/1*K9bpGKr0zj3aEGvvXAR6Ng.jpeg",
        category: "Web3.0",
        isBookmarked: false,
        createdAt: "Mar 23. 2023",
        author: .contentMock1,
        translator: .userMock1,
        contributors: [.qMock1, .userMock2],
        images: ["HottestImage1", "hot2"]
    )
}
