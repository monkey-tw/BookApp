//
//  AddBookPageView.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/20.
//

import SwiftUI
import Combine
import Platform

struct AddBookPageView: View {
    @ObservedObject var viewModel: AddBookViewModel
    
    var body: some View {
        Form {
            TextField("Book Title", text: $viewModel.bookTitle)
            TextField("Book Author", text: $viewModel.author)
            TextField("Book isbn", text: $viewModel.isbn)
            DatePicker("DatePicker", selection: $viewModel.date, displayedComponents: [.date])
            
            Button {
                viewModel.addBook()
            } label: {
                Text("Add a new book")
            }
            .buttonStyle(RoundedRectangleButtonStyle())
            .disabled(!viewModel.isButtonEnabled)
        }
    }
}
