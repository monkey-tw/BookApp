//
//  StandardAddBookRepository.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/20.
//

import Foundation
import Combine
import Networking
import Platform

final class StandardAddBookRepository: AddBookRepository {
    let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func addBook(entity: BookEntity) -> AnyPublisher<BookEntity, HttpError> {
        let params = DataTools.convertCodableToDict(entity) ?? [:]
        return apiClient.request(.addBook(params))
    }
}
