import Foundation

public enum LoadStatus {
    case loading
    case loadSuccess
    case loadFailure(Error?)
}
