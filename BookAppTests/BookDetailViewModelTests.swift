//
//  BookDetailViewModelTests.swift
//  BookAppTests
//
//  Created by Jiaxin Pu on 2024/4/20.
//

import XCTest
import Combine
@testable import BookApp

final class BookDetailViewModelTests: XCTestCase {
    var useCase: MockBookDetailUseCase!
    var sut: BookDetailViewModel!
    let bookModel: BookModel = .init(title: "title1", author: "author1", publicationYear: "publicationYear1", isbn: "isbn1")
    private var cancellable: Set<AnyCancellable> = .init()
    
    override func setUpWithError() throws {
        useCase = MockBookDetailUseCase(scenario: .success)
    }

    override func tearDownWithError() throws {
    }

    func test_whenClickUpdateButton_thenUpdateSuccessfully() {
        // Given
        useCase = MockBookDetailUseCase(scenario: .success)
        sut = BookDetailViewModel(useCase: useCase, bookModel: bookModel)
        let bookTitle = "title1"
        let entity: BookEntity = .init(title: bookTitle, author: "author1", publicationYear: "publicationYear1", isbn: "isbn1")
        let expectation = XCTestExpectation(description: "update a book successfully")
        sut.$newBook
            .dropFirst()
            .sink { book in
                XCTAssertNotNil(book)
                XCTAssertEqual(book?.title, bookTitle)
                expectation.fulfill()
            }
            .store(in: &cancellable)
        
        // When
        sut.sendAction(.updateBook(entity))
        
        // Then
        wait(for: [expectation], timeout: 1)
    }
    
    func test_whenClickUpdateButton_thenHasError() throws {
        // Given
        useCase = MockBookDetailUseCase(scenario: .failed)
        sut = BookDetailViewModel(useCase: useCase, bookModel: bookModel)
        let bookTitle = "title1"
        let entity: BookEntity = .init(title: bookTitle, author: "author1", publicationYear: "publicationYear1", isbn: "isbn1")
        let expectation = XCTestExpectation(description: "update a book failed")
        sut.$requestError
            .dropFirst()
            .sink { error in
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
            .store(in: &cancellable)
        
        // When
        sut.sendAction(.updateBook(entity))
        
        // Then
        wait(for: [expectation], timeout: 1)
    }
    
    func test_whenClickDeleteButton_thenUpdateSuccessfully() {
        // Given
        useCase = MockBookDetailUseCase(scenario: .success)
        sut = BookDetailViewModel(useCase: useCase, bookModel: bookModel)
        let expectation = XCTestExpectation(description: "delete a book successfully")
        sut.$deletedMessage
            .dropFirst()
            .sink { message in
                XCTAssertNotNil(message)
                expectation.fulfill()
            }
            .store(in: &cancellable)
        
        // When
        sut.sendAction(.deleteBook("isbn"))
        
        // Then
        wait(for: [expectation], timeout: 1)
    }
    
    func test_whenClickDeleteButton_thenHasError() throws {
        // Given
        useCase = MockBookDetailUseCase(scenario: .failed)
        sut = BookDetailViewModel(useCase: useCase, bookModel: bookModel)
        let expectation = XCTestExpectation(description: "delete a book successfully")
        sut.$requestError
            .dropFirst()
            .sink { error in
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
            .store(in: &cancellable)
        
        // When
        sut.sendAction(.deleteBook("isbn"))
        
        // Then
        wait(for: [expectation], timeout: 1)
    }
}