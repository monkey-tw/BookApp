//
//  HomeViewModel.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/19.
//

import Foundation
import Combine
import Platform

class HomeViewModel: ObservableObject {
    enum Action {
        case requestBookList(isShowLoading: Bool)
        case pushToAddBookPage
        case pushToBookDetailPage(BookModel)
    }
    @Published var books: [BookModel] = []
    let loadStatus: PassthroughSubject<LoadStatus, Never> = .init()
    
    let useCase: HomeUseCase
    let navigator: HomeNavigator
    private var cancelable: Set<AnyCancellable> = .init()
    
    init(useCase: HomeUseCase, navigator: HomeNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    func sendAction(_ action: Action) {
        switch action {
        case .requestBookList(let isShowLoading):
            if isShowLoading {
                self.loadStatus.send(.loading)
            }
            useCase.requestBookList()
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        if isShowLoading {
                            self.loadStatus.send(.loadFailure(error))
                        }
                    }
                } receiveValue: { books in
                    self.books = books
                    if isShowLoading {
                        self.loadStatus.send(.loadSuccess)
                    }
                }.store(in: &cancelable)
        case .pushToAddBookPage:
            self.navigator.pushToAddBookPage()
        case let .pushToBookDetailPage(model):
            navigator.pushToBookDetailPage(model)
        }
    }
    
    func getBookIconName(_ index: Int) -> String {
        return "book-\(index%6)"
    }
}
