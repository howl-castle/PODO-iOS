//
//  UserData.swift
//  PODO
//
//  Created by Ethan on 2023/03/11.
//

import Foundation

struct UserData: Decodable {
    let id: Int?
    let name: String?
    let profileImagePath: String?
    let job: String?
    let isBookmark: Bool?
}

// MARK: - Mock
extension UserData {

    static let mock1 = UserData(id: 1,
                                name: "Marthin Choi",
                                profileImagePath: "https://img.hankyung.com/photo/201912/01.21183801.1.jpg",
                                job: "Developer",
                                isBookmark: true)

    static let myMock = UserData(id: 2,
                                 name: "Lee",
                                 profileImagePath: "https://img.hankyung.com/photo/201912/01.21183801.1.jpg",
                                 job: "Designer",
                                 isBookmark: true)
}

extension UserData {

    static let hottestMock1 = UserData(id: 3,
                                       name: "Playkey Team",
                                       profileImagePath: "hotUser1",
                                       job: "Developer",
                                       isBookmark: true)
    static let hottestMock2 = UserData(id: 4,
                                       name: "Krull R",
                                       profileImagePath: "hotUser2",
                                       job: "Designer",
                                       isBookmark: false)

    static let qMock1 = UserData(id: 5,
                                 name: "Arthur Hayes",
                                 profileImagePath: "QUser1",
                                 job: "Developer",
                                 isBookmark: false)
    static let qMock2 = UserData(id: 6,
                                 name: "Triny Lee",
                                 profileImagePath: "QUser2",
                                 job: "Designer",
                                 isBookmark: false)
    static let qMock3 = UserData(id: 7,
                                 name: "Vitalik Buterin",
                                 profileImagePath: "QUser3",
                                 job: "Developer",
                                 isBookmark: false)

    static let userMock1 = UserData(id: 8,
                                    name: "Damin Lee",
                                    profileImagePath: "User1",
                                    job: "Developer",
                                    isBookmark: false)
    static let userMock2 = UserData(id: 9,
                                    name: "Marthin Choi",
                                    profileImagePath: "User2",
                                    job: "Developer",
                                    isBookmark: false)
    static let userMock3 = UserData(id: 9,
                                    name: "Yarik",
                                    profileImagePath: "User3",
                                    job: "Developer",
                                    isBookmark: false)
    
}
