//
//  HomeBookItemView.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/19.
//

import SwiftUI

struct HomeBookItemView: View {
    let bookModel: BookModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(bookModel.title)
            Text(bookModel.author)
            Text(bookModel.publicationYear)
            Text(bookModel.ISBN)
        }
    }
}

