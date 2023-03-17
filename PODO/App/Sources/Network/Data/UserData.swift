//
//  UserData.swift
//  PODO
//
//  Created by Ethan on 2023/03/11.
//

import Foundation

struct UserData: Decodable {
    // 서버에 추가 요청 필요.
    let id: Int?

    let name: String?
    let profileImage: String?
    let job: String?

    // 서버에 추가 요청 필요.
    let isBookmark: Bool?
    let profileColor: String?

    // 제거 필요.
    var profileImageIcon: String?
}

// MARK: - Mock
extension UserData {

    static let mock1 = UserData(id: 1,
                                name: "Marthin Choi",
                                profileImage: "https://img.hankyung.com/photo/201912/01.21183801.1.jpg",
                                job: "Developer",
                                isBookmark: true,
                                profileColor: nil)

    static let myMock = UserData(id: 2,
                                 name: "Lee",
                                 profileImage: "https://img.hankyung.com/photo/201912/01.21183801.1.jpg",
                                 job: "Designer",
                                 isBookmark: true,
                                 profileColor: nil)
}

extension UserData {

    static let contentMock1 = UserData(id: 22,
                                       name: "DevArt",
                                       profileImage: "https://image.mycelebs.com/celeb/new/sq/1472_sq_1652168213.jpg",
                                       job: "Developer",
                                       isBookmark: true,
                                       profileColor: nil)

    static let nowMock1 = UserData(id: 33,
                                   name: "Codeart",
                                   profileImage: "https://img.hankyung.com/photo/201912/01.21183801.1.jpg",
                                   job: "Designer",
                                   isBookmark: true,
                                   profileColor: nil)

    static let nowMock2 = UserData(id: 44,
                                   name: "PyCoach",
                                   profileImage: "https://img.sbs.co.kr/newsnet/etv/upload/2021/11/10/30000723808_1280.jpg",
                                   job: "Developer",
                                   isBookmark: true,
                                   profileColor: nil)

    static let hottestMock1 = UserData(id: 3,
                                       name: "Playkey Team",
                                       profileImage: nil,
                                       job: "Developer",
                                       isBookmark: true,
                                       profileColor: nil,
                                       profileImageIcon: "hotUser1")
    static let hottestMock2 = UserData(id: 4,
                                       name: "Krull R",
                                       profileImage: nil,
                                       job: "Designer",
                                       isBookmark: false,
                                       profileColor: nil,
                                       profileImageIcon: "hotUser2")

    static let qMock1 = UserData(id: 5,
                                 name: "Arthur Hayes",
                                 profileImage: nil,
                                 job: "Developer",
                                 isBookmark: false,
                                 profileColor: nil,
                                 profileImageIcon: "QUser1")
    static let qMock2 = UserData(id: 6,
                                 name: "Triny Lee",
                                 profileImage: nil,
                                 job: "Designer",
                                 isBookmark: false,
                                 profileColor: nil,
                                 profileImageIcon: "QUser2")
    static let qMock3 = UserData(id: 7,
                                 name: "Vitalik Buterin",
                                 profileImage: nil,
                                 job: "Developer",
                                 isBookmark: false,
                                 profileColor: nil,
                                 profileImageIcon: "QUser3")

    static let userMock1 = UserData(id: 8,
                                    name: "Damin Lee",
                                    profileImage: nil,
                                    job: "Developer",
                                    isBookmark: false,
                                    profileColor: nil,
                                    profileImageIcon: "User1")
    static let userMock2 = UserData(id: 9,
                                    name: "Marthin Choi",
                                    profileImage: nil,
                                    job: "Developer",
                                    isBookmark: false,
                                    profileColor: nil,
                                    profileImageIcon: "User2")
    static let userMock3 = UserData(id: 9,
                                    name: "Yarik",
                                    profileImage: nil,
                                    job: "Developer",
                                    isBookmark: false,
                                    profileColor: nil,
                                    profileImageIcon: "User3")
    
}
