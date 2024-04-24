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
                    .font(.title3)
                Text(bookModel.author)
                    .font(.caption)
                    .foregroundColor(Color.gray)
                Text(bookModel.publicationYear)
                    .font(.caption)
                    .foregroundColor(Color.gray)
                Text(bookModel.isbn)
                    .font(.caption2)
                    .foregroundColor(Color.gray)
            }.layoutPriority(1)
            Spacer()
            Image(systemName: "arrow.right")
                .foregroundColor(.blue)
        }.contentShape(Rectangle())
    }
}
