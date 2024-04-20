import Foundation

public final class DataTools {
    public static func convertCodableToDict(_ entity: Codable) -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(entity) else {
            return nil
        }
        return try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
    }
}
