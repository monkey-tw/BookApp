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
            HStack {
                Text("Book Title:")
                    .foregroundColor(.gray)
                TextField("Book Title", text: $viewModel.bookTitle)
            }
            HStack {
                Text("Book Author:")
                    .foregroundColor(.gray)
                TextField("Book Author", text: $viewModel.author)
            }
            HStack {
                Text("ISBN:")
                    .foregroundColor(.gray)
                Text(viewModel.bookModel.isbn)
            }
            HStack {
                Text("Publication Year:")
                    .foregroundColor(.gray)
                DatePicker("", selection: $viewModel.publicationDate, displayedComponents: [.date])
            }
            
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
