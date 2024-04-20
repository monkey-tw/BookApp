//
//  MockHomeNavigator.swift
//  BookAppTests
//
//  Created by Jiaxin Pu on 2024/4/20.
//

import Foundation
@testable import BookApp

final class MockHomeNavigator: HomeNavigator {
    enum Scenario {
        case pushToAddBookPage
        case popToLastPage
    }
    
    var scenario: Scenario?
    
    func pushToAddBookPage() {
        scenario = .pushToAddBookPage
    }
    
    func popToLastPage() {
        scenario = .popToLastPage
    }
}
