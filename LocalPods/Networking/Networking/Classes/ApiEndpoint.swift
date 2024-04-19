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
}

extension ApiEndpoint: TargetType {
    public var baseURL: URL {
        return .init(string: "https://example.com")!
    }
    
    public var path: String {
        switch self {
        case .bookList:
            return "/bookList"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .bookList:
            return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .bookList:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
