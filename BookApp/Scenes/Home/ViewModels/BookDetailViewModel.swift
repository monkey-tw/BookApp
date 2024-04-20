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
    }
    @Published var requestError: Error?
    @Published var newBook: BookModel?
    
    let useCase: BookDetailUseCase
    let bookModel: BookModel
    let iconName: String
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
    
    init(useCase: BookDetailUseCase, bookModel: BookModel, iconName: String) {
        self.useCase = useCase
        self.bookModel = bookModel
        self.iconName = iconName
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
