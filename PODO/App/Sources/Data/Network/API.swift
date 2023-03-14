//
//  API.swift
//  PODO
//
//  Created by Yun on 2023/03/15.
//

import Foundation

protocol API {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: APIMethod { get }
    var allHTTPHeaderFields: [String: String] { get }
    var task: APITask { get }
}

enum APIMethod: String {
    case `get` = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum APITask {
    case requestPlain
    case requestData(Data)
    case requestJSONEncodable(Encodable)
    case requestURLParameters([String: String])
}
