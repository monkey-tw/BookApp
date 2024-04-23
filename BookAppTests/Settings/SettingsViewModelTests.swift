//
//  SettingsViewModelTests.swift
//  BookAppTests
//
//  Created by Jiaxin Pu on 2024/4/23.
//

import XCTest
import Combine
@testable import BookApp

final class SettingsViewModelTests: XCTestCase {
    var baseUrlManager: MockBaseUrlManager!
    var sut: SettingsViewModel!
    private var cancellable: Set<AnyCancellable> = .init()
    
    override func setUpWithError() throws {
        baseUrlManager = MockBaseUrlManager()
    }

    override func tearDownWithError() throws {
        baseUrlManager = nil
    }
    
    func test_whenCallSendChangeChannelAction_thenChangeSuccessfully() {
        // Given
        baseUrlManager.channel = .aws
        sut = SettingsViewModel(baseUrlManager: baseUrlManager)
        
        // When
        sut.sendAction(.changeChannel(.local))
        
        // Then
        XCTAssertEqual(baseUrlManager.channel, .local)
    }
    
}
