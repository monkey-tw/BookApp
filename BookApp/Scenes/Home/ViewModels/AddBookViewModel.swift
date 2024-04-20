//
//  AddBookViewModel.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/20.
//

import Foundation
import Combine

final class AddBookViewModel {
    enum Action {
        case addBook(BookEntity)
    }
    @Published var requestError: Error?
    @Published var newBook: BookModel?
    
    let useCase: AddBookUseCase
    private var cancelable: Set<AnyCancellable> = .init()
    
    init(useCase: AddBookUseCase) {
        self.useCase = useCase
    }
    
    func sendAction(_ action: Action) {
        switch action {
        case .addBook(let entity):
            useCase.addBook(entity: entity)
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
