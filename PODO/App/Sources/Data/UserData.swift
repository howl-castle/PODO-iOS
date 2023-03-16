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
    let profileColor: String?

    var profileImage: String?
}

// MARK: - Mock
extension UserData {

    static let mock1 = UserData(id: 1,
                                name: "Marthin Choi",
                                profileImagePath: "https://img.hankyung.com/photo/201912/01.21183801.1.jpg",
                                job: "Developer",
                                isBookmark: true,
                                profileColor: nil)

    static let myMock = UserData(id: 2,
                                 name: "Lee",
                                 profileImagePath: "https://img.hankyung.com/photo/201912/01.21183801.1.jpg",
                                 job: "Designer",
                                 isBookmark: true,
                                 profileColor: nil)
}

extension UserData {

    static let contentMock1 = UserData(id: 22,
                                       name: "DevArt",
                                       profileImagePath: "https://image.mycelebs.com/celeb/new/sq/1472_sq_1652168213.jpg",
                                       job: "Developer",
                                       isBookmark: true,
                                       profileColor: nil)

    static let nowMock1 = UserData(id: 33,
                                   name: "Codeart",
                                   profileImagePath: "https://img.hankyung.com/photo/201912/01.21183801.1.jpg",
                                   job: "Designer",
                                   isBookmark: true,
                                   profileColor: nil)

    static let nowMock2 = UserData(id: 44,
                                   name: "PyCoach",
                                   profileImagePath: "https://img.sbs.co.kr/newsnet/etv/upload/2021/11/10/30000723808_1280.jpg",
                                   job: "Developer",
                                   isBookmark: true,
                                   profileColor: nil)

    static let hottestMock1 = UserData(id: 3,
                                       name: "Playkey Team",
                                       profileImagePath: nil,
                                       job: "Developer",
                                       isBookmark: true,
                                       profileColor: nil,
                                       profileImage: "hotUser1")
    static let hottestMock2 = UserData(id: 4,
                                       name: "Krull R",
                                       profileImagePath: nil,
                                       job: "Designer",
                                       isBookmark: false,
                                       profileColor: nil,
                                       profileImage: "hotUser2")

    static let qMock1 = UserData(id: 5,
                                 name: "Arthur Hayes",
                                 profileImagePath: nil,
                                 job: "Developer",
                                 isBookmark: false,
                                 profileColor: nil,
                                 profileImage: "QUser1")
    static let qMock2 = UserData(id: 6,
                                 name: "Triny Lee",
                                 profileImagePath: nil,
                                 job: "Designer",
                                 isBookmark: false,
                                 profileColor: nil,
                                 profileImage: "QUser2")
    static let qMock3 = UserData(id: 7,
                                 name: "Vitalik Buterin",
                                 profileImagePath: nil,
                                 job: "Developer",
                                 isBookmark: false,
                                 profileColor: nil,
                                 profileImage: "QUser3")

    static let userMock1 = UserData(id: 8,
                                    name: "Damin Lee",
                                    profileImagePath: nil,
                                    job: "Developer",
                                    isBookmark: false,
                                    profileColor: nil,
                                    profileImage: "User1")
    static let userMock2 = UserData(id: 9,
                                    name: "Marthin Choi",
                                    profileImagePath: nil,
                                    job: "Developer",
                                    isBookmark: false,
                                    profileColor: nil,
                                    profileImage: "User2")
    static let userMock3 = UserData(id: 9,
                                    name: "Yarik",
                                    profileImagePath: nil,
                                    job: "Developer",
                                    isBookmark: false,
                                    profileColor: nil,
                                    profileImage: "User3")
    
}
