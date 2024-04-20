//
//  BookDetailUseCase.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/20.
//

import Foundation
import Networking
import Combine

protocol BookDetailUseCase {
    func updateBook(entity: BookEntity) -> AnyPublisher<BookModel, HttpError>
}
