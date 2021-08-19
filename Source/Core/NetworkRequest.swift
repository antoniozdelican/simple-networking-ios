//
//  NetworkRequest.swift
//  SimpleNetworking
//
//  Created by Antonio Zdelican on 28.07.21.
//

import Foundation

public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public typealias RequestHeaders = [String: String]
public typealias RequestParameters = [String : Any?]

/// Protocol to which all APIRequests need to conform.
public protocol NetworkRequestProtocol {
    var baseUrl: String? { get }
    var path: String { get }
    var method: RequestMethod { get }
    var headers: RequestHeaders? { get }
    var parameters: RequestParameters? { get }
}

extension NetworkRequestProtocol {

    func urlRequest() -> URLRequest? {
        guard let baseUrl = self.baseUrl, let url = url(with: baseUrl) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = jsonBody

        return request
    }

    private func url(with baseURL: String) -> URL? {
        guard var urlComponents = URLComponents(string: baseURL) else {
            return nil
        }
        urlComponents.path = urlComponents.path + path
        urlComponents.queryItems = queryItems

        return urlComponents.url
    }

    private var queryItems: [URLQueryItem]? {
        guard method == .get, let parameters = parameters else {
            return nil
        }
        return parameters.map { (key: String, value: Any?) -> URLQueryItem in
            let valueString = String(describing: value)
            return URLQueryItem(name: key, value: valueString)
        }
    }

    private var jsonBody: Data? {
        // The body data should be used for POST and PUT only
        guard [.post, .put].contains(method), let parameters = parameters else {
            return nil
        }
        var jsonBody: Data?
        do {
            jsonBody = try JSONSerialization.data(withJSONObject: parameters,
                                                  options: .prettyPrinted)
        } catch {
            print(error)
        }
        return jsonBody
    }
}
