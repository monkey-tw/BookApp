//
//  AddBookRepository.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/20.
//

import Foundation
import Networking
import Combine

protocol AddBookRepository {
    func addBook(entity: BookEntity) -> AnyPublisher<BookEntity, HttpError>
}
