//
//  Network.swift
//  PODO
//
//  Created by Ethan on 2023/03/14.
//

import Foundation

final class Network {

    func request<T: Decodable>(api: API) async -> Result<T, Error> {
        do {
            let result = try await URLSession.shared.data(for: self.makeRequest(api: api))
            let decoder = JSONDecoder()

            let str = String(decoding: result.0, as: UTF8.self)
            print("@@@@@@ str: \(str)")

            let json = try JSONSerialization.jsonObject(with: result.0, options: []) as? [String: Any]
            print("@@@@@@ json: \(json)")

            if let decoded = try? decoder.decode(T.self, from: result.0) {
                return .success(decoded)
            } else {
                throw NSError(domain: "Network", code: 0)
            }
        } catch {
            print("@@@@@@ failure: \(error)")
            return .failure(error)
        }
    }

    private func makeRequest(api: API) -> URLRequest {
        var url: URL
        if #available(iOS 16.0, *) {
            url = api.baseURL.appending(path: api.path)
        } else {
            url = api.baseURL.appendingPathComponent(api.path)
        }

        var request = URLRequest(url: url)
        switch api.task {
        case let .requestData(data):
            request.httpBody = data
        case let .requestJSONEncodable(encodable):
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(encodable) {
                request.httpBody = encoded
            }
        case let .requestURLParameters(parameters):
            let queryItems = parameters.map {
                URLQueryItem(name: $0.key, value: $0.value) }
            if let paramAddedURL = url.appending(queryParam: parameters) {
                url = paramAddedURL
                request = URLRequest(url: url)
            }
        default: break
        }

        request.httpMethod = api.httpMethod.rawValue
        request.allHTTPHeaderFields = api.allHTTPHeaderFields

        return request
    }
}

private extension URL {

    func appending(queryParam: [String: String]) -> URL? {
        var component = URLComponents(url: self, resolvingAgainstBaseURL: true)
        let queryParamItems = queryParam.map { URLQueryItem(name: $0.key, value: $0.value) }
        let queryItems = (component?.queryItems ?? []) + queryParamItems
        component?.queryItems = queryItems
        return component?.url
    }
}
