//
//  StandardHomeRepository.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/19.
//

import Foundation
import Combine
import Networking

final class StandardHomeRepository: HomeRepository {
    let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func requestBookList() -> AnyPublisher<[BookEntity], Networking.HttpError> {
        return apiClient.request(.bookList)
    }
}
