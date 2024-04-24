//
//  BookDetailRepositoryTests.swift
//  BookAppTests
//
//  Created by Jiaxin Pu on 2024/4/24.
//

import XCTest
import Combine
@testable import BookApp

final class BookDetailRepositoryTests: XCTestCase {
    var apiClient: MockApiClient!
    var sut: StandardBookDetailRepository!
    private var cancellable: Set<AnyCancellable> = .init()
    
    override func setUpWithError() throws {}
    
    override func tearDownWithError() throws {}
    
    func test_whenCallUpdateBook_thenUpdateSuccessfully() {
        // Given
        let entity = BookEntity(
            id: "id1",
            title: "title1",
            author: "author1",
            publicationYear: "publicationYear1",
            isbn: "isbn1"
        )
        let apiClient = MockApiClient(scenario: .success(entity))
        sut = StandardBookDetailRepository(apiClient: apiClient)
        let expectation = expectation(description: "Update book success")
        
        // When
        sut.updateBook(entity: entity)
            .sink { _ in
            } receiveValue: { book in
                XCTAssertEqual(entity.isbn, book.isbn)
                expectation.fulfill()
            }.store(in: &cancellable)

        // Then
        wait(for: [expectation], timeout: 0.1)
    }

    func test_whenUpdateBook_thenHasError() {
        // Given
        let apiClient = MockApiClient(scenario: .failed)
        sut = StandardBookDetailRepository(apiClient: apiClient)
        let expectation = expectation(description: "Update book fail")
        let entity = BookEntity(
            id: "id1",
            title: "title1",
            author: "author1",
            publicationYear: "publicationYear1",
            isbn: "isbn1"
        )
        
        // When
        sut.updateBook(entity: entity)
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
    
    func test_whenCallDeleteBook_thenDeleteSuccessfully() {
        // Given
        let entity = BookEntity(
            id: "id1",
            title: "title1",
            author: "author1",
            publicationYear: "publicationYear1",
            isbn: "isbn1"
        )
        let apiClient = MockApiClient(scenario: .success(entity))
        sut = StandardBookDetailRepository(apiClient: apiClient)
        let expectation = expectation(description: "Delete book success")
        
        // When
        sut.deleteBook(id: entity.id)
            .sink { _ in
            } receiveValue: { book in
                XCTAssertEqual(entity.id, book.id)
                expectation.fulfill()
            }.store(in: &cancellable)

        // Then
        wait(for: [expectation], timeout: 0.1)
    }

    func test_whenDeleteBook_thenHasError() {
        // Given
        let apiClient = MockApiClient(scenario: .failed)
        sut = StandardBookDetailRepository(apiClient: apiClient)
        let expectation = expectation(description: "Delete book fail")
        let entity = BookEntity(
            id: "id1",
            title: "title1",
            author: "author1",
            publicationYear: "publicationYear1",
            isbn: "isbn1"
        )
        
        // When
        sut.deleteBook(id: entity.id)
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