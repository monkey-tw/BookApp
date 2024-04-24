//
//  AddBookUseCaseTests.swift
//  BookAppTests
//
//  Created by Jiaxin Pu on 2024/4/24.
//

import XCTest
import Combine
@testable import BookApp

final class AddBookUseCaseTests: XCTestCase {
    var repository: MockAddBookRepository!
    var sut: StandardAddBookUseCase!
    private var cancellable: Set<AnyCancellable> = .init()
    
    override func setUpWithError() throws {
        repository = MockAddBookRepository(scenario: .success)
    }

    override func tearDownWithError() throws {
        repository = nil
    }

    func test_whenCallAddBook_thenAddSuccessfully() {
        // Given
        sut = StandardAddBookUseCase(repository: repository)
        let expectation = expectation(description: "Add book success")
        let entity = BookEntity(
            id: "id1",
            title: "title1",
            author: "author1",
            publicationYear: "publicationYear1",
            isbn: "isbn1"
        )
        
        // When
        sut.addBook(entity: entity)
            .sink { _ in
            } receiveValue: { book in
                XCTAssertEqual(entity.isbn, book.isbn)
                expectation.fulfill()
            }.store(in: &cancellable)

        // Then
        wait(for: [expectation], timeout: 0.1)
    }

    func test_whenCallAddBook_thenHasError() {
        // Given
        repository = MockAddBookRepository(scenario: .failed)
        sut = StandardAddBookUseCase(repository: repository)
        let expectation = expectation(description: "Add book fail")
        let entity = BookEntity(
            id: "id1",
            title: "title1",
            author: "author1",
            publicationYear: "publicationYear1",
            isbn: "isbn1"
        )
        
        // When
        sut.addBook(entity: entity)
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
