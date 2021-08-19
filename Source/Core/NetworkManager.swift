//
//  NetworkManager.swift
//  PrimerCheckout
//
//  Created by Antonio Zdelican on 28.07.21.
//

import Foundation

internal protocol NetworkManagerProtocol {
    init(networkSession: NetworkSessionProtocol)
    func execute(request: NetworkRequestProtocol, completion: @escaping (OperationResult) -> Void) -> URLSessionTask?
}

/// Handles the dispatch of requests with a given configuration.
internal class NetworkManager: NetworkManagerProtocol {

    private let networkSession: NetworkSessionProtocol

    required init(networkSession: NetworkSessionProtocol) {
        self.networkSession = networkSession
    }

    func execute(request: NetworkRequestProtocol, completion: @escaping (OperationResult) -> Void) -> URLSessionTask? {
        guard let urlRequest = request.urlRequest() else {
            completion(.error(NetworkError.invalidUrl("\(request)"), nil))
            return nil
        }
        Logger.logRequest(urlRequest)
        let task = networkSession.dataTask(with: urlRequest, completion: { [weak self] (data, urlResponse, error) in
            self?.handleJsonTaskResponse(with: urlRequest, data: data, urlResponse: urlResponse, error: error, completion: completion)
        })
        task?.resume()

        return task
    }

    private func handleJsonTaskResponse(with request: URLRequest, data: Data?, urlResponse: URLResponse?, error: Error?, completion: @escaping (OperationResult) -> Void) {
        guard let urlResponse = urlResponse as? HTTPURLResponse else {
            completion(OperationResult.error(NetworkError.invalidResponse, nil))
            return
        }
        let result = verify(data: data, urlResponse: urlResponse, error: error)
        switch result {
        case .success(let data):
            let parseResult = parse(data: data as? Data)
            switch parseResult {
            case .success(let json):
                Logger.logResponse(request, urlResponse: urlResponse, data: data as? Data, error: nil)
                DispatchQueue.main.async {
                    completion(OperationResult.json(json, urlResponse))
                }
            case .failure(let error):
                Logger.logResponse(request, urlResponse: urlResponse, data: nil, error: error)
                DispatchQueue.main.async {
                    completion(OperationResult.error(error, urlResponse))
                }
            }
        case .failure(let error):
            Logger.logResponse(request, urlResponse: urlResponse, data: nil, error: error)
            DispatchQueue.main.async {
                completion(OperationResult.error(error, urlResponse))
            }
        }
    }

    private func parse(data: Data?) -> Result<Any, Error> {
        guard let data = data else {
            return .failure(NetworkError.invalidResponse)
        }

        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            return .success(json)
        } catch (let error) {
            return .failure(NetworkError.parseError(error.localizedDescription))
        }
    }

    private func verify(data: Any?, urlResponse: HTTPURLResponse, error: Error?) -> Result<Any, Error> {
        switch urlResponse.statusCode {
        case 200...299:
            if let data = data {
                return .success(data)
            } else {
                return .failure(NetworkError.noData)
            }
        case 400...499:
            return .failure(NetworkError.badRequest(error?.localizedDescription))
        case 500...599:
            return .failure(NetworkError.serverError(error?.localizedDescription))
        default:
            return .failure(NetworkError.unknown(error?.localizedDescription))
        }
    }
}
