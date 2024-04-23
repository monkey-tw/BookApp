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
    var baseUrlManager: BaseUrlManager { get }
}

class StandardAppDependencies: AppDependencies {
    let apiClient: ApiClient
    var baseUrlManager: BaseUrlManager
    
    init() {
        apiClient = StandardApiClient()
        baseUrlManager = StandardBaseUrlManager.instance
    }
}
