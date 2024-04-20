//
//  AddBookUseCase.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/20.
//

import Foundation
import Networking
import Combine

protocol AddBookUseCase {
    func addBook(entity: BookEntity) -> AnyPublisher<BookModel, HttpError>
}

class StandardAddBookUseCase: AddBookUseCase {
    let repository: AddBookRepository
    
    init(repository: AddBookRepository) {
        self.repository = repository
    }
    
    func addBook(entity: BookEntity) -> AnyPublisher<BookModel, HttpError> {
        return repository.addBook(entity: entity)
            .map { BookModel.init(from: $0) }
            .eraseToAnyPublisher()
    }
}
