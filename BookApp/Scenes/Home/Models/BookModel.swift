//
//  BookModel.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/19.
//

import Foundation

struct BookModel: Identifiable {
    var id: String {
        return isbn
    }
    let title: String
    let author: String
    let publicationYear: String
    let isbn: String
    
    init(title: String, author: String, publicationYear: String, isbn: String) {
        self.title = title
        self.author = author
        self.publicationYear = publicationYear
        self.isbn = isbn
    }
    
    init(from entity: BookEntity) {
        self.title = entity.title
        self.author = entity.author
        self.publicationYear = entity.publicationYear
        self.isbn = entity.isbn
    }
}

extension BookModel {
    func toEntity() -> BookEntity {
        BookEntity(title: title, author: author, publicationYear: publicationYear, isbn: isbn)
    }
}
