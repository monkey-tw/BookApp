import Moya
import Combine

public enum HttpError: Error {
    case serverError(Error?)
    case invalidDataError(Error?)
}

public protocol ApiClient {
    func request<T: Decodable>(_ endpoint: ApiEndpoint) -> AnyPublisher<T, MoyaError>
}

public class StandardApiClient: ApiClient {
    private let provider = MoyaProvider<ApiEndpoint>()
    
    public init() {
    }
    
    public func request<T: Decodable>(_ endpoint: ApiEndpoint) ->  AnyPublisher<T, MoyaError> {
        return provider.requestPublisher(endpoint).map(T.self).eraseToAnyPublisher()
    }
}
