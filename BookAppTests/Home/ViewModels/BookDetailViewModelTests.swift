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
    var navigator: MockHomeNavigator!
    var sut: BookDetailViewModel!
    let bookModel: BookModel = .init(
        id: "id1",
        title: "title1",
        author: "author1",
        publicationYear: "publicationYear1",
        isbn: "isbn1"
    )
    private var cancellable: Set<AnyCancellable> = .init()
    
    override func setUpWithError() throws {
        useCase = MockBookDetailUseCase(scenario: .success)
        navigator = MockHomeNavigator()
    }

    override func tearDownWithError() throws {
        useCase = nil
        navigator = nil
    }

    func test_whenClickUpdateButton_thenUpdateSuccessfully() {
        // Given
        useCase = MockBookDetailUseCase(scenario: .success)
        sut = BookDetailViewModel(useCase: useCase, navigator: navigator, bookModel: bookModel)
        let bookTitle = "title1"
        let entity: BookEntity = .init(
            id: "id",
            title: bookTitle,
            author: "author1",
            publicationYear: "publicationYear1",
            isbn: "isbn1"
        )
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
        sut = BookDetailViewModel(useCase: useCase, navigator: navigator, bookModel: bookModel)
        let bookTitle = "title1"
        let entity: BookEntity = .init(
            id: "id",
            title: bookTitle,
            author: "author1",
            publicationYear: "publicationYear1",
            isbn: "isbn1"
        )
        let expectation = XCTestExpectation(description: "update a book failed")
        sut.loadStatus
            .dropFirst()
            .sink { status in
                if case .loadFailure = status {
                    expectation.fulfill()
                }
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
        sut = BookDetailViewModel(useCase: useCase, navigator: navigator, bookModel: bookModel)
        let expectation = XCTestExpectation(description: "delete a book successfully")
        sut.$deletedModel
            .dropFirst()
            .sink { model in
                XCTAssertNotNil(model)
                expectation.fulfill()
            }
            .store(in: &cancellable)
        
        // When
        sut.sendAction(.deleteBook("id"))
        
        // Then
        wait(for: [expectation], timeout: 1)
    }
    
    func test_whenClickDeleteButton_thenHasError() throws {
        // Given
        useCase = MockBookDetailUseCase(scenario: .failed)
        sut = BookDetailViewModel(useCase: useCase, navigator: navigator, bookModel: bookModel)
        let expectation = XCTestExpectation(description: "delete a book successfully")
        sut.loadStatus
            .dropFirst()
            .sink { status in
                if case .loadFailure = status {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellable)
        
        // When
        sut.sendAction(.deleteBook("id"))
        
        // Then
        wait(for: [expectation], timeout: 1)
    }
}
