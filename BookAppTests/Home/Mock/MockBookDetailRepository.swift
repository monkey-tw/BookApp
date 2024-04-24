//
//  MockBookDetailRepository.swift
//  BookAppTests
//
//  Created by Jiaxin Pu on 2024/4/24.
//

import Foundation
import Combine
@testable import BookApp
@testable import Networking

class MockBookDetailRepository: BookDetailRepository {
    enum Scenario {
        case success
        case failed
    }
    
    let scenario: Scenario
    
    init(scenario: Scenario) {
        self.scenario = scenario
    }
    
    func updateBook(entity: BookEntity) -> AnyPublisher<BookEntity, HttpError> {
        switch scenario {
        case .success:
            return Just(entity)
                .setFailureType(to: HttpError.self)
                .eraseToAnyPublisher()
        case .failed:
            return Fail(error: HttpError.serverError(nil))
                .eraseToAnyPublisher()
        }
    }
    
    func deleteBook(id: String) -> AnyPublisher<BookEntity, HttpError> {
        switch scenario {
        case .success:
            let entity = BookEntity(
                id: id,
                title: "title1",
                author: "author1",
                publicationYear: "publicationYear1",
                isbn: "isbn1"
            )
            return Just(entity)
                .setFailureType(to: HttpError.self)
                .eraseToAnyPublisher()
        case .failed:
            return Fail(error: HttpError.serverError(nil))
                .eraseToAnyPublisher()
        }
    }
}
