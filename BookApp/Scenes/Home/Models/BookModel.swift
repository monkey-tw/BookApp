//
//  BookModel.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/19.
//

import Foundation

struct BookModel {
    let title: String
    let author: String
    let publicationYear: String
    let ISBN: String
    
    init(title: String, author: String, publicationYear: String, ISBN: String) {
        self.title = title
        self.author = author
        self.publicationYear = publicationYear
        self.ISBN = ISBN
    }
    
    init(from entity: BookEntity) {
        self.title = entity.title
        self.author = entity.author
        self.publicationYear = entity.publicationYear
        self.ISBN = entity.ISBN
    }
}
