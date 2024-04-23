//
//  ResponseWrapper.swift
//  Networking
//
//  Created by Jiaxin Pu on 2024/4/19.
//

import Foundation

public enum BaseUrlChannel: String {
    case aws
    case local
}

public protocol BaseUrlManager {
    var channel: BaseUrlChannel { get set }
}

public class StandardBaseUrlManager: BaseUrlManager {
    public var channel: BaseUrlChannel {
        get {
            let channelString = UserDefaults.standard.string(forKey: baseUrlChannelKey)
            return BaseUrlChannel(rawValue: channelString ?? "") ?? .aws
        }
        set {
            UserDefaults.standard.setValue(newValue.rawValue, forKey: baseUrlChannelKey)
            NotificationCenter.default.post(name: .baseUrlChannelDidUpdated, object: nil)
        }
    }
    public static let instance: StandardBaseUrlManager = .init()
    
    private let baseUrlChannelKey: String = "baseUrlChannelKey"
}

public extension Notification.Name {
    static let baseUrlChannelDidUpdated: Notification.Name = .init("com.book.notification.baseUrlChannelDidUpdated")
}
