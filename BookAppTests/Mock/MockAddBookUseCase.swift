//
//  MockAddBookUseCase.swift
//  BookAppTests
//
//  Created by Jiaxin Pu on 2024/4/20.
//

import Foundation
import Combine
@testable import BookApp
@testable import Networking

final class MockAddBookUseCase: AddBookUseCase {
    enum Scenario {
        case success
        case failed
    }
    
    let scenario: Scenario
    
    init(scenario: Scenario) {
        self.scenario = scenario
    }
    
    func addBook(entity: BookEntity) -> AnyPublisher<BookModel, HttpError> {
        switch scenario {
        case .success:
            return Just(BookModel(from: entity))
                .setFailureType(to: HttpError.self)
                .eraseToAnyPublisher()
        case .failed:
            return Fail(error: HttpError.serverError(nil))
                .eraseToAnyPublisher()
        }
    }
}
