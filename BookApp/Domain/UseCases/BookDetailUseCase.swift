//
//  BookDetailUseCase.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/20.
//

import Foundation
import Networking
import Combine

protocol BookDetailUseCase {
    func updateBook(entity: BookEntity) -> AnyPublisher<BookModel, HttpError>
    func deleteBook(id: String) -> AnyPublisher<BookModel, HttpError>
}

class StandardBookDetailUseCase: BookDetailUseCase {
    let repository: BookDetailRepository
    
    init(repository: BookDetailRepository) {
        self.repository = repository
    }
    
    func updateBook(entity: BookEntity) -> AnyPublisher<BookModel, HttpError> {
        return repository.updateBook(entity: entity)
            .map { BookModel.init(from: $0) }
            .eraseToAnyPublisher()
    }
    
    func deleteBook(id: String) -> AnyPublisher<BookModel, HttpError> {
        return repository.deleteBook(id: id)
            .map { BookModel.init(from: $0) }
            .eraseToAnyPublisher()
    }
}
