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
        case pushToAddBookPage
        case pushToBookDetailPage(BookModel, String)
    }
    @Published var books: [BookModel] = []
    @Published var requestError: Error?
    
    let useCase: HomeUseCase
    let navigator: HomeNavigator
    private var cancelable: Set<AnyCancellable> = .init()
    
    init(useCase: HomeUseCase, navigator: HomeNavigator) {
        self.useCase = useCase
        self.navigator = navigator
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
        case .pushToAddBookPage:
            self.navigator.pushToAddBookPage()
        case let .pushToBookDetailPage(model, icon):
            navigator.pushToBookDetailPage(model, icon)
        }
    }
    
    func getBookIconName(_ index: Int) -> String {
        return "book-\(index%6)"
    }
}
