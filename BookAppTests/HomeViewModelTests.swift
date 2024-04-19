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
    var sut: HomeViewModel!
    private var cancellable: Set<AnyCancellable> = .init()
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test_whenCallRequestBookListAction_thenHasBooks() throws {
        // Given
        let useCase = MockHomeUseCase(scenario: .success)
        sut = HomeViewModel(useCase: useCase)
        let expectation = XCTestExpectation(description: "publish 2 books")
        sut.$books
            .dropFirst()
            .sink { books in
                XCTAssertEqual(books.count, 2)
                expectation.fulfill()
            }
            .store(in: &cancellable)
        
        // When
        sut.sendAction(.requestBookList)
        
        // Then
        wait(for: [expectation], timeout: 1)
    }

    func test_whenCallRequestBookListAction_thenHasError() throws {
        // Given
        let useCase = MockHomeUseCase(scenario: .failed)
        sut = HomeViewModel(useCase: useCase)
        let expectation = XCTestExpectation(description: "receive server error")
        sut.$requestError
            .dropFirst()
            .sink { error in
                XCTAssertTrue(error != nil)
                expectation.fulfill()
            }
            .store(in: &cancellable)
        
        // When
        sut.sendAction(.requestBookList)
        
        // Then
        wait(for: [expectation], timeout: 1)
    }
}
