//
//  TabAPI.swift
//  PODO
//
//  Created by Yun on 2023/03/17.
//

import Foundation

enum TabAPI {
    case home
    case expert
    case revenue
    case setting
}

extension TabAPI: API {

    var path: String {
        switch self {
        case .home:     return ""
        case .expert:   return ""
        case .revenue:  return ""
        case .setting:  return ""
        }
    }

    var httpMethod: APIMethod {
        switch self {
        case .home:     fallthrough
        case .expert:   fallthrough
        case .revenue:  fallthrough
        case .setting:  return .get
        }
    }

    var task: APITask {
        switch self {
        case .home:     fallthrough
        case .expert:   fallthrough
        case .revenue:  fallthrough
        case .setting:  return .requestPlain
        }
    }
}
