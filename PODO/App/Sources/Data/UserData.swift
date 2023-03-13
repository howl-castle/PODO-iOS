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
