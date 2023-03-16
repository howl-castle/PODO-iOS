//
//  InterestData.swift
//  PODO
//
//  Created by Ethan on 2023/03/11.
//

import Foundation

enum InterestData: String, Decodable, CaseIterable {
    case all = "All"
    case web = "Web3.0"
    case ton = "TON"
    case design = "Design"
    case ai = "Artificial Intelligence"
    case si = "Self-Improvement"
}

// mock
extension InterestData {

    static let mock1: [InterestData] = [.web, .ton]
    static let mock2: [InterestData] = [.web]
    static let mock3: [InterestData] = [.ton]
    static let mock4: [InterestData] = [.design]
}
