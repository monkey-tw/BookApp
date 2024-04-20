//
//  AddBookViewModelTests.swift
//  BookAppTests
//
//  Created by Jiaxin Pu on 2024/4/20.
//

import XCTest
import Combine
@testable import BookApp

final class AddBookViewModelTests: XCTestCase {
    var useCase: MockAddBookUseCase!
    var navigator: MockHomeNavigator!
    var sut: AddBookViewModel!
    private var cancellable: Set<AnyCancellable> = .init()
    
    override func setUpWithError() throws {
        useCase = MockAddBookUseCase(scenario: .success)
        navigator = MockHomeNavigator()
    }

    override func tearDownWithError() throws {
    }

    func test_whenClickAddButton_thenAddSuccessfully() {
        // Given
        useCase = MockAddBookUseCase(scenario: .success)
        sut = AddBookViewModel(useCase: useCase, navigator: navigator)
        let bookTitle = "title1"
        let entity: BookEntity = .init(title: bookTitle, author: "author1", publicationYear: "publicationYear1", ISBN: "ISBN1")
        let expectation = XCTestExpectation(description: "add a book")
        sut.$newBook
            .dropFirst()
            .sink { book in
                XCTAssertNotNil(book)
                XCTAssertEqual(book?.title, bookTitle)
                expectation.fulfill()
            }
            .store(in: &cancellable)
        
        // When
        sut.sendAction(.addBook(entity))
        
        // Then
        wait(for: [expectation], timeout: 1)
    }
    
    func test_whenClickAddButton_thenHasError() throws {
        // Given
        useCase = MockAddBookUseCase(scenario: .failed)
        sut = AddBookViewModel(useCase: useCase, navigator: navigator)
        let bookTitle = "title1"
        let entity: BookEntity = .init(title: bookTitle, author: "author1", publicationYear: "publicationYear1", ISBN: "ISBN1")
        let expectation = XCTestExpectation(description: "add a book then receive a error")
        sut.$requestError
            .dropFirst()
            .sink { error in
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
            .store(in: &cancellable)
        
        // When
        sut.sendAction(.addBook(entity))
        
        // Then
        wait(for: [expectation], timeout: 1)
    }
    
    func test_whenSendBackToHomePageAction_thenPopToLastPage() {
        // Given
        useCase = MockAddBookUseCase(scenario: .success)
        sut = AddBookViewModel(useCase: useCase, navigator: navigator)
        
        // When
        sut.sendAction(.backToHomePage)
        
        // Then
        XCTAssertEqual(navigator.scenario, .popToLastPage)
    }
}
