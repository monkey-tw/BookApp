//
//  MockAddBookRepository.swift
//  BookAppTests
//
//  Created by Jiaxin Pu on 2024/4/24.
//

import Foundation
import Combine
@testable import BookApp
@testable import Networking

class MockAddBookRepository: AddBookRepository {
    enum Scenario {
        case success
        case failed
    }
    
    let scenario: Scenario
    
    init(scenario: Scenario) {
        self.scenario = scenario
    }
    
    func addBook(entity: BookEntity) -> AnyPublisher<BookEntity, HttpError> {
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
}
