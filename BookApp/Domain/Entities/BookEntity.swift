//
//  BookEntity.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/19.
//

import Foundation
import Platform

struct BookEntity: Codable {
    let id: String
    let title: String
    let author: String
    let publicationYear: String
    let isbn: String
}
