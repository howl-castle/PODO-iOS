//
//  ArticleAPI.swift
//  PODO
//
//  Created by Yun on 2023/03/15.
//

import Foundation

enum ArticleAPI {
    case list
    case detail(id: Int)
}

extension ArticleAPI: API {

    var path: String {
        switch self {
        case .list:     return "article_list"
        case .detail:   return "article"
        }
    }

    var httpMethod: APIMethod {
        switch self {
        case .list:     fallthrough
        case .detail:   return .get
        }
    }

    var task: APITask {
        switch self {
        case .list:
            return .requestPlain
        case .detail(let id):
            return .requestURLParameters(["id": "\(id)"])
        }
    }
}
