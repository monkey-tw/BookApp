//
//  BookDetailPageView.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/20.
//

import SwiftUI
import Combine
import Platform

struct BookDetailPageView: View {
    @ObservedObject var viewModel: BookDetailViewModel
    
    var body: some View {
        Form {
            Text("Click text to edit, exclude isbn")
                .foregroundColor(.gray)
            TextField("Book Title", text: $viewModel.bookTitle)
            TextField("Book Author", text: $viewModel.author)
            Text(viewModel.bookModel.isbn)
            DatePicker("DatePicker", selection: $viewModel.date, displayedComponents: [.date])
            
            HStack(spacing: 16) {
                Button(action: {
                    viewModel.sendAction(.updateBook(viewModel.getNewBookEntity()))
                }, label: {
                    Text("Update")
                })
                .buttonStyle(RoundedRectangleButtonStyle())
                .disabled(!viewModel.isButtonEnabled)
                
                Button(action: {
                    viewModel.sendAction(.deleteBook(viewModel.bookModel.id))
                }, label: {
                    Text("Delete")
                })
                .buttonStyle(RoundedRectangleButtonStyle(labelColor: .red))
            }
        }
    }
}
