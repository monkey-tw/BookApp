//
//  MockApiClient.swift
//  BookAppTests
//
//  Created by Jiaxin Pu on 2024/4/24.
//

import Foundation
@testable import BookApp
import Networking
import Combine

class MockApiClient: ApiClient {
    enum Scenario {
        case success(Any)
        case failed
    }
    
    let scenario: Scenario
    
    init(scenario: Scenario) {
        self.scenario = scenario
    }
    
    // swiftlint:disable force_cast
    func request<T>(_ endpoint: ApiEndpoint) -> AnyPublisher<T, HttpError> where T : Decodable {
        switch scenario {
        case .success(let data):
            return Just(data)
                .map { $0 as! T }
                .setFailureType(to: HttpError.self)
                .eraseToAnyPublisher()
        case .failed:
            return Fail(error: HttpError.serverError(nil))
                .eraseToAnyPublisher()
        }
    }
}
