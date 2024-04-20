//
//  Notifications.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/20.
//

import Foundation

extension Notification.Name {
    static let bookDidUpdated: Notification.Name = .init("com.book.notification.bookDidUpdated")
    static let bookDidAdded: Notification.Name = .init("com.book.notification.bookDidAdded")
    static let bookDidDeleted: Notification.Name = .init("com.book.notification.bookDidDeleted")
}
