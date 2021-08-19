//
//  Logger.swift
//  SimpleNetworking
//
//  Created by Antonio Zdelican on 06.08.21.
//

import Foundation

internal struct Logger {
    
    static func log(level: LogLevel, title: String, message: String, file: String? = nil, function: String? = nil, line: UInt? = nil) {
        #if DEBUG
        guard level != .verbose else {
            /// Don't log verbose for now
            return
        }
        
        var log: String = "\nSIMPLE CHECKOUT "
        
        /// LogLevel
        switch level {
        case .verbose:
            log += "[VERBOSE]"
        case .debug:
            log += "[DEBUG]"
        case .info:
            log += "[INFO]"
        case .warning:
            log += "[WARNING]"
        case .error:
            log += "[ERROR]"
        }
        
        /// Date
        log += " @ \(Date().string)" + "\n"
        
        /// Position
        var positionElements: [String] = []
        if let file = file {
            positionElements.append(file)
        }
        if let function = function {
            positionElements.append(function)
        }
        if let line = line {
            positionElements.append(String(line))
        }
        if !positionElements.isEmpty {
            log += "[\(positionElements.joined(separator: " -> "))]" + "\n"
        }
        
        /// Title
        log += title + "\n"
        
        /// Message
        log += message + "\n"
        
        print(log)
        #endif
    }
}

extension Logger {

    // MARK: Network logs
    
    static func logRequest(_ urlRequest: URLRequest) {
        #if DEBUG
        var message = ""
        
        /// Headers
        message += "Headers:" + "\n" + "\(urlRequest.allHTTPHeaderFields ?? [:])" + "\n"
        
        /// Body
        if let httpBody = urlRequest.httpBody {
            var body: String = "Empty body"
            let jsonObject = try? JSONSerialization.jsonObject(with: httpBody, options: .allowFragments)
            if let jsonObject = jsonObject {
                let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                if let jsonData = jsonData, let jsonString = String(data: jsonData, encoding: .utf8 ) {
                    body = jsonString
                }
            }
            message += "Body:" + "\n" + "\(body)" + "\n"
        }
        
        /// Query params
        if let query = urlRequest.url?.query {
            message += "Query parameters: \(query)" + "\n"
        }
        
        /// Title
        let title = logTitle(urlRequest, isRequestTitle: true)
        
        // Log
        Logger.log(level: .debug, title: title, message: message)
        #endif
    }
    
    static func logResponse(_ urlRequest: URLRequest, urlResponse: HTTPURLResponse, data: Data?, error: Error?) {
        #if DEBUG
        var message = ""
        
        /// Status
        message += "Status:" + "\n" + "\(urlResponse.statusCode)" + "\n"

        /// Headers
        message += "Headers:" + "\n" + "\(urlResponse.allHeaderFields)" + "\n"
        
        /// Error
        if let error = error {
            message += "\n" + "Error: \(error)"
            let title = logTitle(urlRequest, isRequestTitle: false)
            Logger.log(level: .error, title: title, message: message)
            return
        }
        
        /// Data
        guard let data = data else {
            message += "\n" + "No data received"
            let title = logTitle(urlRequest, isRequestTitle: false)
            Logger.log(level: .error, title: title, message: message)
            return
        }
        
        var responseData: String = "Empty data"
        let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
        if let jsonObject = jsonObject {
            let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
            if let jsonData = jsonData, let jsonString = String(data: jsonData, encoding: .utf8 ) {
                responseData = jsonString
            }
        }
        message += "Body:" + "\n" + "\(responseData)" + "\n"
        
        /// Title
        let title = logTitle(urlRequest, isRequestTitle: false)
        
        // Log
        Logger.log(level: .debug, title: title, message: message)
        #endif
    }
    
    static func logTitle(_ urlRequest: URLRequest, isRequestTitle: Bool) -> String {
        var title = "\n" + "\(isRequestTitle ? "NETWORK REQUEST" : "NETWORK RESPONSE")" + "\n" + "----------------"
        if let httpMethod = urlRequest.httpMethod, let url = urlRequest.url {
            title += "\n" + "[\(httpMethod)] \(url)"
        }
        return title
    }
}

internal enum LogLevel {
    case verbose
    case debug
    case info
    case warning
    case error
}
