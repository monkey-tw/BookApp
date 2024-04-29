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
    case deleteBook(String)
}

extension ApiEndpoint: TargetType {
    public var baseURL: URL {
        switch StandardBaseUrlManager.instance.channel {
        case .aws:
            return .init(string: "http://3.27.26.5:8080")!
        case .local:
            return .init(string: "http://localhost:8080")!
        }
    }
    
    public var path: String {
        switch self {
        case .bookList:
            return "/books"
        case .addBook:
            return "/books"
        case let .updateBook(id, _):
            return "/books/\(id)"
        case let .deleteBook(id):
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
        case .deleteBook:
            return .delete
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
        case .deleteBook:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
