import Moya
import Combine

public enum HttpError: Error {
    case serverError(Error?)
}

public protocol ApiClient {
    func request<T: Decodable>(_ endpoint: ApiEndpoint) -> AnyPublisher<T, HttpError>
}

public class StandardApiClient: ApiClient {
    private let provider = MoyaProvider<ApiEndpoint>()
    
    public init() {
    }
    
    public func request<T: Decodable>(_ endpoint: ApiEndpoint) ->  AnyPublisher<T, HttpError> {
        return provider.requestPublisher(endpoint)
            .map(T.self)
            .mapError{ HttpError.serverError($0) }
            .eraseToAnyPublisher()
    }
}
