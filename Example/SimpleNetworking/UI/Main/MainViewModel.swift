//
//  MainViewModel.swift
//  SimpleNetworking_Example
//
//  Created by Antonio Zdelican on 20.08.21.
//  Copyright © 2021 antoniozdelican. All rights reserved.
//

import Foundation

class MainViewModel {
    
    let data: [APIRequest] = [
        APIRequest.getExample,
        APIRequest.postExample,
        APIRequest.putExample,
        APIRequest.deleteExample
    ]
}
