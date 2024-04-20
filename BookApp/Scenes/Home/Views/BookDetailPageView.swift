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
            Text("Click text to edit, exclude ISBN")
                .foregroundColor(.gray)
            TextField("Book Title", text: $viewModel.bookTitle)
            TextField("Book Author", text: $viewModel.author)
            Text(viewModel.bookModel.ISBN)
            DatePicker("DatePicker", selection: $viewModel.date, displayedComponents: [.date])
            
            HStack(spacing: 16) {
                Button(action: {
                    viewModel.sendAction(.updateBook(viewModel.bookModel.toEntity()))
                }, label: {
                    Text("Update")
                })
                .buttonStyle(RoundedRectangleButtonStyle())
                .disabled(!viewModel.isButtonEnabled)
                
                Button(action: {
                    
                }, label: {
                    Text("Delete")
                })
                .buttonStyle(RoundedRectangleButtonStyle(labelColor: .red))
            }
        }
    }
}
