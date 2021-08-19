//
//  NetworkOperation.swift
//  PrimerCheckout
//
//  Created by Antonio Zdelican on 28.07.21.
//

import Foundation

internal protocol NetworkOperationProtocol {
    func execute(in networkManager: NetworkManagerProtocol, completion: @escaping (OperationResult) -> Void) ->  Void
    func cancel() -> Void
}

/// Executes and cancels a network request.
internal class NetworkOperation: NetworkOperationProtocol {
    
    private var task: URLSessionTask?
    private var request: NetworkRequestProtocol

    init(_ request: NetworkRequestProtocol) {
        self.request = request
    }
    
    func execute(in networkManager: NetworkManagerProtocol, completion: @escaping (OperationResult) -> Void) {
        task = networkManager.execute(request: request, completion: { result in
            completion(result)
        })
    }

    func cancel() {
        task?.cancel()
    }
}

/// The expected result of a Network Operation.
internal enum OperationResult {
    case json(_ : Any, _ : HTTPURLResponse?)
    case error(_ : Error, _ : HTTPURLResponse?)
}
