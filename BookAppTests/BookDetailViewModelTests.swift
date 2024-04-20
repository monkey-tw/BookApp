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
    private var cancellable: Set<AnyCancellable> = .init()
    
    override func setUpWithError() throws {
        useCase = MockBookDetailUseCase(scenario: .success)
    }

    override func tearDownWithError() throws {
    }

    func test_whenClickUpdateButton_thenUpdateSuccessfully() {
        // Given
        useCase = MockBookDetailUseCase(scenario: .success)
        sut = BookDetailViewModel(useCase: useCase)
        let bookTitle = "title1"
        let entity: BookEntity = .init(title: bookTitle, author: "author1", publicationYear: "publicationYear1", ISBN: "ISBN1")
        let expectation = XCTestExpectation(description: "update a book")
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
}
