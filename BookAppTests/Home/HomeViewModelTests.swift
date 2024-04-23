//
//  BookAppTests.swift
//  BookAppTests
//
//  Created by Jiaxin Pu on 2024/4/19.
//

import XCTest
import Combine
@testable import BookApp

final class HomeViewModelTests: XCTestCase {
    var useCase: MockHomeUseCase!
    var navigator: MockHomeNavigator!
    var sut: HomeViewModel!
    private var cancellable: Set<AnyCancellable> = .init()
    
    override func setUpWithError() throws {
        useCase = MockHomeUseCase(scenario: .success)
        navigator = MockHomeNavigator()
    }

    override func tearDownWithError() throws {
        useCase = nil
        navigator = nil
    }

    func test_whenCallRequestBookListAction_thenHasBooks() throws {
        // Given
        useCase = MockHomeUseCase(scenario: .success)
        sut = HomeViewModel(useCase: useCase, navigator: navigator)
        let expectation = XCTestExpectation(description: "publish 2 books")
        sut.$books
            .dropFirst()
            .sink { books in
                XCTAssertEqual(books.count, 2)
                expectation.fulfill()
            }
            .store(in: &cancellable)
        
        // When
        sut.sendAction(.requestBookList(isShowLoading: true))
        
        // Then
        wait(for: [expectation], timeout: 1)
    }

    func test_whenCallRequestBookListAction_thenHasError() throws {
        // Given
        useCase = MockHomeUseCase(scenario: .failed)
        sut = HomeViewModel(useCase: useCase, navigator: navigator)
        let expectation = XCTestExpectation(description: "receive server error")
        sut.loadStatus
            .dropFirst()
            .sink { status in
                if case .loadFailure(_) = status {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellable)
        
        // When
        sut.sendAction(.requestBookList(isShowLoading: true))
        
        // Then
        wait(for: [expectation], timeout: 1)
    }
    
    func test_whenClickAddButton_thenPushToAddBookPage() throws {
        // Given
        sut = HomeViewModel(useCase: useCase, navigator: navigator)
        
        // When
        sut.sendAction(.pushToAddBookPage)
        
        // Then
        XCTAssertEqual(navigator.scenario, .pushToAddBookPage)
    }
    
    func test_whenClickBookItem_thenPushToBookDetailPage() throws {
        // Given
        sut = HomeViewModel(useCase: useCase, navigator: navigator)
        let bookModel = BookModel(id: "id1", title: "title1", author: "author1", publicationYear: "publicationYear1", isbn: "isbn1")
        
        // When
        sut.sendAction(.pushToBookDetailPage(bookModel))
        
        // Then
        XCTAssertEqual(navigator.scenario, .pushToBookDetailPage)
    }
}
