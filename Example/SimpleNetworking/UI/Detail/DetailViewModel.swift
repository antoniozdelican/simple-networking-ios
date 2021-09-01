//
//  DetailViewModel.swift
//  SimpleNetworking_Example
//
//  Created by Antonio Zdelican on 20.08.21.
//  Copyright © 2021 antoniozdelican. All rights reserved.
//

import Foundation
import SimpleNetworking

enum Section: String {
    case headers = "Headers"
    case body = "Body"
}

class DetailViewModel {
    
    let sections: [Section] = [
        Section.headers,
        Section.body
    ]
    private let networkManager: NetworkManager

    init() {
        self.networkManager = NetworkManager(networkSession: NetworkSession())
    }
    
    func callApi(_ request: APIRequest, completion: @escaping (Result<String?, Error>, HTTPURLResponse?) -> Void) {
        let networkOperation = NetworkOperation(request)
        
        networkOperation.execute(in: networkManager) { result in
            switch result {
            case .json(let jsonObject, let response):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                    let jsonString = String(data: jsonData, encoding: .utf8 )
                    completion(.success(jsonString), response)
                } catch (let error) {
                    completion(.failure(NetworkError.parseError(error.localizedDescription)), nil)
                }
            case .error(let error, _):
                completion(.failure(error), nil)
            }
        }
    }
}
