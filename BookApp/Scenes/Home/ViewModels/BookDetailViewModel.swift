//
//  BookDetailViewModel.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/20.
//

import Foundation
import Combine
import Moya
import Platform

final class BookDetailViewModel: ObservableObject {
    enum Action {
        case updateBook(BookEntity)
        case deleteBook(String)
    }
    enum LoadSucces {
        case updateBook
        case deleteBook
    }
    @Published var newBook: BookModel?
    @Published var deletedModel: BookModel?
    
    let useCase: BookDetailUseCase
    let navigator: HomeNavigator
    let bookModel: BookModel
    private var cancelable: Set<AnyCancellable> = .init()
    
    @Published var bookTitle = "" {
        didSet {
            checkButtonStatus()
        }
    }
    @Published var author = "" {
        didSet {
            checkButtonStatus()
        }
    }
    @Published var date: Date = .init()
    @Published var isButtonEnabled = false
    let loadStatus: PassthroughSubject<LoadStatus<LoadSucces>, Never> = .init()
    
    init(useCase: BookDetailUseCase, navigator: HomeNavigator, bookModel: BookModel) {
        self.useCase = useCase
        self.navigator = navigator
        self.bookModel = bookModel
        bookTitle = bookModel.title
        author = bookModel.author
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: bookModel.publicationYear) {
            self.date = date
        }
    }
    
    func sendAction(_ action: Action) {
        switch action {
        case .updateBook(let entity):
            loadStatus.send(.loading)
            useCase.updateBook(entity: entity)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self.loadStatus.send(.loadFailure(error))
                    }
                } receiveValue: { model in
                    self.newBook = model
                    self.loadStatus.send(.loadSuccess(.updateBook))
                    NotificationCenter.default.post(name: .bookDidUpdated, object: nil)
            }.store(in: &cancelable)
        case .deleteBook(let id):
            loadStatus.send(.loading)
            useCase.deleteBook(id: id)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self.loadStatus.send(.loadFailure(error))
                    }
                } receiveValue: { model in
                    self.deletedModel = model
                    self.loadStatus.send(.loadSuccess(.deleteBook))
                    NotificationCenter.default.post(name: .bookDidDeleted, object: nil)
                    self.navigator.popToLastPage()
            }.store(in: &cancelable)
        }
    }
    
    func getNewBookEntity() -> BookEntity {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let publicationYear = dateFormatter.string(from: date)
        return .init(id: bookModel.id, title: bookTitle, author: author, publicationYear: publicationYear, isbn: bookModel.isbn)
    }
    
    private func checkButtonStatus() {
        if !bookTitle.isEmpty && !author.isEmpty {
            isButtonEnabled = true
        } else {
            isButtonEnabled = false
        }
    }
}
