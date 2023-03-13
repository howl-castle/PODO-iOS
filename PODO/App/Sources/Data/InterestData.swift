//
//  InterestData.swift
//  PODO
//
//  Created by Ethan on 2023/03/11.
//

import Foundation

struct InterestData: Decodable {
    let title: String?
}

// MARK: - Mock
extension InterestData {

    static let mocks: [InterestData] = [
        .init(title: "Web3.0"),
        .init(title: "Artificial Intelligence"),
        .init(title: "Design"),
        .init(title: "Investment"),
        .init(title: "Self-Improvement")
    ]
}
