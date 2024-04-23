//
//  MockBaseUrlManager.swift
//  BookAppTests
//
//  Created by Jiaxin Pu on 2024/4/23.
//

import Foundation
@testable import BookApp
import Networking

class MockBaseUrlManager: BaseUrlManager {
    var channel: BaseUrlChannel = .aws
}
