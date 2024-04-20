//
//  AddBookViewModel.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/20.
//

import Foundation
import Combine

final class AddBookViewModel: ObservableObject {
    enum Action {
        case addBook(BookEntity)
        case backToHomePage
    }
    @Published var requestError: Error?
    @Published var newBook: BookModel?
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
    @Published var ISBN = "" {
        didSet {
            checkButtonStatus()
        }
    }
    @Published var date: Date = .init() {
        didSet {
            checkButtonStatus()
        }
    }
    @Published var isButtonEnabled = false
    
    let useCase: AddBookUseCase
    let navigator: HomeNavigator
    private var cancelable: Set<AnyCancellable> = .init()
    
    init(useCase: AddBookUseCase, navigator: HomeNavigator) {
        self.useCase = useCase
        self.navigator = navigator
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
                    NotificationCenter.default.post(name: .bookDidAdded, object: nil)
            }.store(in: &cancelable)
        case .backToHomePage:
            navigator.popToLastPage()
        }
    }
    
    func addBook() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let publicationYear = dateFormatter.string(from: date)
        let entity = BookEntity(title: bookTitle, author: author, publicationYear: publicationYear, ISBN: ISBN)
        sendAction(.addBook(entity))
    }
    
    private func checkButtonStatus() {
        if !bookTitle.isEmpty && !author.isEmpty && !ISBN.isEmpty {
            isButtonEnabled = true
        } else {
            isButtonEnabled = false
        }
    }
}
