//
//  HomeRepository.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/19.
//

import Foundation
import Networking
import Combine

protocol HomeRepository {
    func requestBookList() -> AnyPublisher<[BookEntity], HttpError>
}
