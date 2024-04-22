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
    @State private var isDeleteAlertPresented: Bool = false
    
    var body: some View {
        Form {
            editGroup
            buttonGroup
        }.alert(isPresented: $isDeleteAlertPresented, content: {
            alertContent
        })
    }
    
    var editGroup: some View {
        Group {
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
        }
    }
    
    var buttonGroup: some View {
        HStack(spacing: 16) {
            Button(action: {
                viewModel.sendAction(.updateBook(viewModel.getNewBookEntity()))
            }, label: {
                Text("Update")
            })
            .buttonStyle(RoundedRectangleButtonStyle())
            .disabled(!viewModel.isButtonEnabled)
            
            Button(action: {
                isDeleteAlertPresented = true
            }, label: {
                Text("Delete")
            })
            .buttonStyle(RoundedRectangleButtonStyle(labelColor: .red))
        }
    }
    
    var alertContent: Alert {
        Alert(
            title: Text("Are you sure to delete the book?"),
            primaryButton: .cancel(Text("Cancel"), action: {}),
            secondaryButton: .default(Text("Delete"), action: {
                viewModel.sendAction(.deleteBook(viewModel.bookModel.id))
            })
        )
    }
}
