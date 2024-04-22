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
            HStack {
                Text("Book Title:")
                    .foregroundColor(.gray)
                TextField("Input Book Title", text: $viewModel.bookTitle)
            }
            HStack {
                Text("Book Author:")
                    .foregroundColor(.gray)
                TextField("Input Book Author", text: $viewModel.author)
            }
            HStack {
                Text("ISBN:")
                    .foregroundColor(.gray)
                TextField("Input Book isbn", text: $viewModel.isbn)
            }
            HStack {
                Text("Publication Year:")
                    .foregroundColor(.gray)
                DatePicker("", selection: $viewModel.date, displayedComponents: [.date])
            }
            
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
