//
//  NetworkSession.swift
//  SimpleNetworking
//
//  Created by Antonio Zdelican on 28.07.21.
//

import Foundation

internal protocol NetworkSessionProtocol {
    func dataTask(with request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask?
}

/// Handles the creation of URLSession task.
internal class NetworkSession: NetworkSessionProtocol {

    private var session: URLSession!
    
    init() {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForResource = 30
        if #available(iOS 11, *) {
            sessionConfiguration.waitsForConnectivity = true
        }
        self.session = URLSession(configuration: sessionConfiguration)
    }

    deinit {
        // We have to invalidate the session becasue URLSession strongly retains its delegate. https://developer.apple.com/documentation/foundation/urlsession/1411538-invalidateandcancel
        session.invalidateAndCancel()
        session = nil
    }
    
    func dataTask(with request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask? {
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }
        return dataTask
    }
}
