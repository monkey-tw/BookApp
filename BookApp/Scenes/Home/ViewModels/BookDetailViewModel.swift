//
//  BookDetailViewModel.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/20.
//

import Foundation
import Combine

final class BookDetailViewModel: ObservableObject {
    enum Action {
        case updateBook(BookEntity)
        case deleteBook(String)
    }
    @Published var requestError: Error?
    @Published var newBook: BookModel?
    @Published var deletedMessage: String?
    
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
                    NotificationCenter.default.post(name: .bookDidUpdated, object: nil)
            }.store(in: &cancelable)
        case .deleteBook(let isbn):
            useCase.deleteBook(isbn: isbn)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self.requestError = error
                    }
                } receiveValue: { message in
                    self.deletedMessage = message
                    NotificationCenter.default.post(name: .bookDidDeleted, object: nil)
                    self.navigator.popToLastPage()
            }.store(in: &cancelable)
        }
    }
    
    private func checkButtonStatus() {
        if !bookTitle.isEmpty && !author.isEmpty {
            isButtonEnabled = true
        } else {
            isButtonEnabled = false
        }
    }
}
