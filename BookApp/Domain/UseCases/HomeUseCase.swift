//
//  HomeUseCase.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/19.
//

import Foundation
import Networking
import Combine

protocol HomeUseCase {
    func requestBookList() -> AnyPublisher<[BookModel], HttpError>
}

class StandardHomeUseCase: HomeUseCase {
    let repository: HomeRepository
    
    init(repository: HomeRepository) {
        self.repository = repository
    }
    
    func requestBookList() -> AnyPublisher<[BookModel], HttpError> {
        return repository.requestBookList()
            .map { entities in
                return entities.map { BookModel.init(from: $0) }
            }
            .eraseToAnyPublisher()
    }
}
