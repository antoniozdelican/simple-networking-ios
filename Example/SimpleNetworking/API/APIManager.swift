//
//  APIManager.swift
//  SimpleNetworking_Example
//
//  Created by Antonio Zdelican on 19.08.21.
//  Copyright © 2021 antoniozdelican. All rights reserved.
//

import Foundation
import SimpleNetworking

protocol APIManagerProtocol {
    func getExample(_ completion: @escaping (Result<String?, Error>) -> Void)
    func postExample(_ completion: @escaping (Result<String?, Error>) -> Void)
    func putExample(_ completion: @escaping (Result<String?, Error>) -> Void)
    func deleteExample(_ completion: @escaping (Result<String?, Error>) -> Void)
}

/// Initializes networkManager, api requests and executes all the api operations
class APIManager: APIManagerProtocol {
    
    private let networkManager: NetworkManager

    init() {
        self.networkManager = NetworkManager(networkSession: NetworkSession())
    }
    
    func getExample(_ completion: @escaping (Result<String?, Error>) -> Void) {
        let request = APIRequest.getExample
        let networkOperation = NetworkOperation(request)
        
        networkOperation.execute(in: networkManager) { result in
            switch result {
            case .json(let jsonObject, _):
                do {
//                    let response = try JSONDecoder().decode(String.self, withJSONObject: jsonObject)
//                    let tokenizationResponse = try JSONDecoder().decode(TokenizationResponse.self, withJSONObject: jsonObject)
                    // TODO:
                    completion(.success(nil))
                } catch (let error) {
                    completion(.failure(NetworkError.parseError(error.localizedDescription)))
                }
            case .error(let error, _):
                completion(.failure(error))
            }
        }
    }
    
    func postExample(_ completion: @escaping (Result<String?, Error>) -> Void) {
        let request = APIRequest.postExample
        let networkOperation = NetworkOperation(request)
        
        networkOperation.execute(in: networkManager) { result in
            switch result {
            case .json(let jsonObject, _):
                do {
//                    let response = try JSONDecoder().decode(String.self, withJSONObject: jsonObject)
//                    let tokenizationResponse = try JSONDecoder().decode(TokenizationResponse.self, withJSONObject: jsonObject)
                    // TODO:
                    completion(.success(nil))
                } catch (let error) {
                    completion(.failure(NetworkError.parseError(error.localizedDescription)))
                }
            case .error(let error, _):
                completion(.failure(error))
            }
        }
    }
    
    func putExample(_ completion: @escaping (Result<String?, Error>) -> Void) {
        let request = APIRequest.putExample
        let networkOperation = NetworkOperation(request)
        
        networkOperation.execute(in: networkManager) { result in
            switch result {
            case .json(let jsonObject, _):
                do {
//                    let response = try JSONDecoder().decode(String.self, withJSONObject: jsonObject)
//                    let tokenizationResponse = try JSONDecoder().decode(TokenizationResponse.self, withJSONObject: jsonObject)
                    // TODO:
                    completion(.success(nil))
                } catch (let error) {
                    completion(.failure(NetworkError.parseError(error.localizedDescription)))
                }
            case .error(let error, _):
                completion(.failure(error))
            }
        }
    }
    
    func deleteExample(_ completion: @escaping (Result<String?, Error>) -> Void) {
        let request = APIRequest.deleteExample
        let networkOperation = NetworkOperation(request)
        
        networkOperation.execute(in: networkManager) { result in
            switch result {
            case .json(let jsonObject, _):
                do {
//                    let response = try JSONDecoder().decode(String.self, withJSONObject: jsonObject)
//                    let tokenizationResponse = try JSONDecoder().decode(TokenizationResponse.self, withJSONObject: jsonObject)
                    // TODO:
                    completion(.success(nil))
                } catch (let error) {
                    completion(.failure(NetworkError.parseError(error.localizedDescription)))
                }
            case .error(let error, _):
                completion(.failure(error))
            }
        }
    }
}
