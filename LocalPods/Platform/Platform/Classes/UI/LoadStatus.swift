import Foundation

public enum LoadStatus<T> {
    case loading
    case loadSuccess(T)
    case loadFailure(Error?)
}
