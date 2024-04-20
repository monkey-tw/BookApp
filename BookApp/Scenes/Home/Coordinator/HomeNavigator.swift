//
//  HomeNavigator.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/19.
//

import Foundation

protocol HomeNavigator {
    func pushToAddBookPage()
    func popToLastPage()
    func pushToBookDetailPage(_ bookModel: BookModel, _ icon: String)
}
