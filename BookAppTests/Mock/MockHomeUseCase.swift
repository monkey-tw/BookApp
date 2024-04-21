//
//  MockHomeUseCase.swift
//  BookAppTests
//
//  Created by Jiaxin Pu on 2024/4/19.
//

import Foundation
import Combine
@testable import BookApp
@testable import Networking

final class MockHomeUseCase: HomeUseCase {
    enum Scenario {
        case success
        case failed
    }
    
    let scenario: Scenario
    
    init(scenario: Scenario) {
        self.scenario = scenario
    }
    
    func requestBookList() -> AnyPublisher<[BookModel], HttpError> {
        switch scenario {
        case .success:
            return Just(successBooks())
                .setFailureType(to: HttpError.self)
                .eraseToAnyPublisher()
        case .failed:
            return Fail(error: HttpError.serverError(nil))
                .eraseToAnyPublisher()
        }
    }
}

private extension MockHomeUseCase {
    func successBooks() -> [BookModel] {
        return [
            .init(id: "id1", title: "title1", author: "author1", publicationYear: "publicationYear1", isbn: "isbn1"),
            .init(id: "id2", title: "title2", author: "author2", publicationYear: "publicationYear2", isbn: "isbn2")
        ]
    }
}
