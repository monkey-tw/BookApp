//
//  HomeViewModel.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/19.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    enum Action {
        case requestBookList
    }
    @Published var books: [BookModel] = []
    @Published var requestError: Error?
    
    let useCase: HomeUseCase
    private var cancelable: Set<AnyCancellable> = .init()
    
    init(useCase: HomeUseCase) {
        self.useCase = useCase
    }
    
    func sendAction(_ action: Action) {
        switch action {
        case .requestBookList:
            useCase.requestBookList()
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self.requestError = error
                    }
                } receiveValue: { books in
                self.books = books
            }.store(in: &cancelable)
        }
    }
}
