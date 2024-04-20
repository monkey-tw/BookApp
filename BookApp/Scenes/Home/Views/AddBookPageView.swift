//
//  AddBookPageView.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/20.
//

import SwiftUI
import Combine

struct AddBookPageView: View {
    @ObservedObject var viewModel: AddBookViewModel
    
    var body: some View {
        Form {
            TextField("Book Title", text: $viewModel.bookTitle)
            TextField("Book Author", text: $viewModel.author)
            TextField("Book ISBN", text: $viewModel.ISBN)
            DatePicker("DatePicker", selection: $viewModel.date, displayedComponents: [.date])
            
            Button {
                viewModel.addBook()
            } label: {
                Text("Add a new book")
            }.disabled(!viewModel.isButtonEnabled)
        }
    }
}
