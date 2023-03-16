//
//  ArticleAPI.swift
//  PODO
//
//  Created by Yun on 2023/03/15.
//

import Foundation

enum ArticleAPI {

    case list
}

extension ArticleAPI: API {

    var path: String {
        switch self {
        case .list: return "article_list"
        }
    }

    var httpMethod: APIMethod {
        switch self {
        case .list: return .get
        }
    }

    var allHTTPHeaderFields: [String : String] {
        switch self {
        case .list: return [:]
        }
    }

    var task: APITask {
        switch self {
        case .list: return .requestPlain
        }
    }
}
