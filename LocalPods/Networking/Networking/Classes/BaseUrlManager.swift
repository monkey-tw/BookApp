//
//  ResponseWrapper.swift
//  Networking
//
//  Created by Jiaxin Pu on 2024/4/19.
//

import Foundation

public enum BaseUrlChannel {
    case aws
    case local
}

public protocol BaseUrlManager {
    var channel: BaseUrlChannel { set get }
}

public class StandardBaseUrlManager: BaseUrlManager {
    public var channel: BaseUrlChannel = .aws {
        didSet {
            NotificationCenter.default.post(name: .baseUrlChannelDidUpdated, object: nil)
        }
    }
    public static let instance: StandardBaseUrlManager = .init()
}

public extension Notification.Name {
    static let baseUrlChannelDidUpdated: Notification.Name = .init("com.book.notification.baseUrlChannelDidUpdated")
}
