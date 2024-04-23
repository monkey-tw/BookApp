//
//  AddBookViewModel.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/20.
//

import Foundation
import Combine
import Platform

final class AddBookViewModel: ObservableObject {
    enum Action {
        case addBook(BookEntity)
        case backToHomePage
    }
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
    @Published var isbn = "" {
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
    let loadStatus: PassthroughSubject<LoadStatus<Void>, Never> = .init()
    
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
            loadStatus.send(.loading)
            useCase.addBook(entity: entity)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self.loadStatus.send(.loadFailure(error))
                    }
                } receiveValue: { model in
                    self.newBook = model
                    self.loadStatus.send(.loadSuccess(()))
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
        let entity = BookEntity(
            id: UUID().uuidString,
            title: bookTitle,
            author: author, 
            publicationYear: publicationYear,
            isbn: isbn
        )
        sendAction(.addBook(entity))
    }
    
    private func checkButtonStatus() {
        if !bookTitle.isEmpty && !author.isEmpty && !isbn.isEmpty {
            isButtonEnabled = true
        } else {
            isButtonEnabled = false
        }
    }
}
