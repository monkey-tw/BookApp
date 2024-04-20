//
//  HomeBookItemView.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/19.
//

import SwiftUI

struct HomeBookItemView: View {
    let bookModel: BookModel
    let bookIconName: String
    
    var body: some View {
        HStack {
            Image(bookIconName, bundle: nil)
                .resizable()
                .frame(width: 85, height: 85)
            VStack(alignment: .leading) {
                Text(bookModel.title)
                Text(bookModel.author)
                Text(bookModel.publicationYear)
                Text(bookModel.isbn)
            }.layoutPriority(1)
            Spacer()
            Image(systemName: "arrow.right")
                .foregroundColor(.blue)
        }
        
    }
}

