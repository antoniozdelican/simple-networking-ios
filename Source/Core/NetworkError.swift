//
//  NetworkError.swift
//  SimpleNetworking
//
//  Created by Antonio Zdelican on 02.08.21.
//

import Foundation

/// Enum of Network Errors
public enum NetworkError: LocalizedError {
    /// No data received from the server.
    case noData
    /// The server response was invalid (unexpected format).
    case invalidResponse
    /// The request url was invalid.
    case invalidUrl(String?)
    /// The request was rejected: 400-499
    case badRequest(String?)
    /// Encoutered a server error.
    case serverError(String?)
    /// There was an error parsing the data.
    case parseError(String?)
    /// Unknown error.
    case unknown(String?)
}

extension NetworkError {
    
    public var errorDescription: String? {
        switch self {
        case .noData:
            return "No data error"
        case .invalidResponse:
            return "Invalid response error"
        case .invalidUrl(let description):
            if let description = description {
                return description
            } else {
                return "Invalid url error"
            }
        case .badRequest(let description):
            if let description = description {
                return description
            } else {
                return "Client error"
            }
        case .serverError(let description):
            if let description = description {
                return description
            } else {
                return "Server error"
            }
        case .parseError(let description):
            if let description = description {
                return description
            } else {
                return "Parsing error"
            }
        case .unknown(let description):
            if let description = description {
                return description
            } else {
                return "Unknown error"
            }
        }
    }
}
