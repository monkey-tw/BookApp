//
//  AppDependencies.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/19.
//

import Foundation
import Networking

protocol AppDependencies {
    var apiClient: ApiClient { get }
}

class StandardAppDependencies: AppDependencies {
    let apiClient: ApiClient
    
    init() {
        apiClient = StandardApiClient()
    }
}
