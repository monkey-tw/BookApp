//
//  ApiEndpoint.swift
//  Networking
//
//  Created by Jiaxin Pu on 2024/4/19.
//

import Foundation
import Moya

public enum ApiEndpoint {
    case bookList
    case addBook([String : Any])
    case updateBook(String, [String : Any])
}

extension ApiEndpoint: TargetType {
    public var baseURL: URL {
        return .init(string: "https://example.com")!
    }
    
    public var path: String {
        switch self {
        case .bookList:
            return "/books"
        case .addBook:
            return "/book"
        case let .updateBook(id, _):
            return "/books/\(id)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .bookList:
            return .get
        case .addBook:
            return .post
        case .updateBook:
            return .put
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .bookList:
            return .requestPlain
        case .addBook(let params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .updateBook(_, let params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
