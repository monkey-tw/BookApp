//
//  ResponseWrapper.swift
//  Networking
//
//  Created by Jiaxin Pu on 2024/4/19.
//

import Foundation

struct ResponseWrapper<T: Decodable>: Decodable {
    let message: String
    let data: T
}
