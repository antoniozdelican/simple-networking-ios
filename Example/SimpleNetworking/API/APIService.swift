//
//  APIService.swift
//  SimpleNetworking_Example
//
//  Created by Antonio Zdelican on 19.08.21.
//  Copyright © 2021 antoniozdelican. All rights reserved.
//

import Foundation

protocol APIServiceProtocol {
    
    func getExample(_ completion: @escaping (Result<String?, Error>) -> Void)
    func postExample(_ completion: @escaping (Result<String?, Error>) -> Void)
    func putExample(_ completion: @escaping (Result<String?, Error>) -> Void)
    func deleteExample(_ completion: @escaping (Result<String?, Error>) -> Void)
}

class TokenizationService: APIServiceProtocol {
    
    func getExample(_ completion: @escaping (Result<String?, Error>) -> Void) {
        APIManager().getExample({ result in
            switch result {
            case .success(let resultString):
                completion(.success(resultString))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func postExample(_ completion: @escaping (Result<String?, Error>) -> Void) {
        APIManager().postExample({ result in
            switch result {
            case .success(let resultString):
                completion(.success(resultString))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func putExample(_ completion: @escaping (Result<String?, Error>) -> Void) {
        APIManager().putExample({ result in
            switch result {
            case .success(let resultString):
                completion(.success(resultString))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func deleteExample(_ completion: @escaping (Result<String?, Error>) -> Void) {
        APIManager().deleteExample({ result in
            switch result {
            case .success(let resultString):
                completion(.success(resultString))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
