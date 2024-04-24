//
//  HomeUseCaseTests.swift
//  BookAppTests
//
//  Created by Jiaxin Pu on 2024/4/24.
//

import XCTest
import Combine
@testable import BookApp

final class HomeUseCaseTests: XCTestCase {
    var repository: MockHomeRepository!
    var sut: StandardHomeUseCase!
    private var cancellable: Set<AnyCancellable> = .init()
    
    override func setUpWithError() throws {
        repository = MockHomeRepository(scenario: .success)
    }

    override func tearDownWithError() throws {
        repository = nil
    }

    func test_whenCallRequestBookList_thenHasBooks() {
        // Given
        sut = StandardHomeUseCase(repository: repository)
        let expectation = expectation(description: "Request book list success")
        // When
        sut.requestBookList()
            .sink { _ in
            } receiveValue: { books in
                XCTAssertFalse(books.isEmpty)
                expectation.fulfill()
            }.store(in: &cancellable)

        // Then
        wait(for: [expectation], timeout: 0.1)
    }

    func test_whenCallRequestBookList_thenHasError() {
        // Given
        repository = MockHomeRepository(scenario: .failed)
        sut = StandardHomeUseCase(repository: repository)
        let expectation = expectation(description: "Request book list fail")
        // When
        sut.requestBookList()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    expectation.fulfill()
                }
            } receiveValue: { _ in
            }.store(in: &cancellable)

        // Then
        wait(for: [expectation], timeout: 0.1)
    }
}
