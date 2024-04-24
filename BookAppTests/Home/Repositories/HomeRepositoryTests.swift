//
//  HomeRepositoryTests.swift
//  BookAppTests
//
//  Created by Jiaxin Pu on 2024/4/24.
//

import XCTest
import Combine
@testable import BookApp

final class HomeRepositoryTests: XCTestCase {
    var apiClient: MockApiClient!
    var sut: StandardHomeRepository!
    var books: [BookEntity] = []
    private var cancellable: Set<AnyCancellable> = .init()
    
    override func setUpWithError() throws {
        books = [
            BookEntity(
                id: "id1",
                title: "title1",
                author: "author1",
                publicationYear: "publicationYear1",
                isbn: "isbn1"
            )
        ]
    }

    override func tearDownWithError() throws {
        books = []
    }
    
    func test_whenCallRequestBookList_thenHasBooks() {
        // Given
        apiClient = MockApiClient(scenario: .success(books))
        sut = StandardHomeRepository(apiClient: apiClient)
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
        apiClient = MockApiClient(scenario: .failed)
        sut = StandardHomeRepository(apiClient: apiClient)
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
