//
//  APIRequest.swift
//  SimpleNetworking_Example
//
//  Created by Antonio Zdelican on 19.08.21.
//  Copyright © 2021 antoniozdelican. All rights reserved.
//

import Foundation
import SimpleNetworking

/// All endpoints with configurations are here. Inherits from NetworkRequestProtocol.
enum APIRequest: NetworkRequestProtocol {
    case getExample
    case postExample
    case putExample
    case deleteExample
}

extension APIRequest {
    
    var baseUrl: String? {
        switch self {
        case .getExample,
             .postExample,
             .putExample,
             .deleteExample:
            return "https://httpbin.org"
        }
    }
    
    var path: String {
        switch self {
        case .getExample:
            return "/get"
        case .postExample:
            return "/post"
        case .putExample:
            return "/put"
        case .deleteExample:
            return "/delete"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .getExample:
            return .get
        case .postExample:
            return .post
        case .putExample:
            return .put
        case .deleteExample:
            return .delete
        }
    }
    
    var headers: RequestHeaders? {
        let headers: RequestHeaders = [
            "Accept" : "application/json"
        ]
        return headers
    }

    var parameters: RequestParameters? {
        switch self {
        case .getExample,
             .postExample,
             .putExample,
             .deleteExample:
            return nil
        }
    }
    
    var title: String {
        switch self {
        case .getExample:
            return "GET Request"
        case .postExample:
            return "POST Request"
        case .putExample:
            return "PUT Request"
        case .deleteExample:
            return "DELETE Request"
        }
    }
    
}
