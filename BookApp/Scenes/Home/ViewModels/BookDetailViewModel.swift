//
//  BookDetailViewModel.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/20.
//

import Foundation
import Combine

final class BookDetailViewModel {
    enum Action {
        case updateBook(BookEntity)
    }
    @Published var requestError: Error?
    @Published var newBook: BookModel?
    
    let useCase: BookDetailUseCase
    private var cancelable: Set<AnyCancellable> = .init()
    
    init(useCase: BookDetailUseCase) {
        self.useCase = useCase
    }
    
    func sendAction(_ action: Action) {
        switch action {
        case .updateBook(let entity):
            useCase.updateBook(entity: entity)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self.requestError = error
                    }
                } receiveValue: { model in
                    self.newBook = model
            }.store(in: &cancelable)
        }
    }
}
