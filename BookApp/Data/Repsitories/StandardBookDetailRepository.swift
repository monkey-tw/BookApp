//
//  StandardBookDetailRepository.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/20.
//

import Foundation
import Combine
import Networking
import Platform

final class StandardBookDetailRepository: BookDetailRepository {
    let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func updateBook(entity: BookEntity) -> AnyPublisher<BookEntity, HttpError> {
        let params = DataTools.convertCodableToDict(entity) ?? [:]
        return apiClient.request(.updateBook(entity.isbn, params))
    }
    
    func deleteBook(isbn: String) -> AnyPublisher<String, HttpError> {
        return apiClient.request(.deleteBook(isbn))
    }
}
